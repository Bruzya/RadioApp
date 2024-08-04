//
//  AudioProcessor.swift
//  RadioApp
//
//  Created by dsm 5e on 03.08.2024.
//

import Foundation
import AVFAudio
import Accelerate

final class AudioProcessor {
    static let sharedInstance = AudioProcessor()

    private let audioEngine = AVAudioEngine()
    private let bufferCapacity = 1024
    private let numberOfBars = 32

    var frequencyMagnitudes: [Float] = []

    private init() {
        setupAudioEngine()
        initializeFFT()
    }

    private func setupAudioEngine() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }

        let inputNode = audioEngine.inputNode
        let audioFormat = inputNode.outputFormat(forBus: 0)

        audioEngine.connect(inputNode, to: audioEngine.mainMixerNode, format: audioFormat)

        do {
            try audioEngine.start()
        } catch {
            print("Failed to start audio engine: \(error)")
        }
    }

    private func initializeFFT() {
        let fftConfiguration = vDSP_DFT_zop_CreateSetup(
            nil,
            UInt(bufferCapacity),
            vDSP_DFT_Direction.FORWARD
        )

        let inputNode = audioEngine.inputNode
        inputNode.installTap(
            onBus: 0,
            bufferSize: UInt32(bufferCapacity),
            format: nil
        ) { [weak self] buffer, _ in
            guard let self = self else { return }
            let channelDataPointer = buffer.floatChannelData?[0]
            self.frequencyMagnitudes = self.performFFT(data: channelDataPointer!, configuration: fftConfiguration!)
        }
    }

    private func performFFT(data: UnsafeMutablePointer<Float>, configuration: OpaquePointer) -> [Float] {
        let realInput = generateRealInput(from: data)
        var (realOutput, imaginaryOutput) = createInOut()

        vDSP_DFT_Execute(configuration, realInput, realInput, &realOutput, &imaginaryOutput)

        let magnitudes = computeMagnitudes(realOutput: &realOutput, imaginaryOutput: &imaginaryOutput)
        let normalizedMagnitudes = normalize(magnitudes: magnitudes)

        return normalizedMagnitudes
    }

    private func generateRealInput(from data: UnsafeMutablePointer<Float>) -> [Float] {
        var realInput = [Float](repeating: 0, count: bufferCapacity)
        for index in 0 ..< bufferCapacity {
            realInput[index] = data[index]
        }
        return realInput
    }

    private func createInOut() -> (real: [Float], imaginary: [Float]) {
        let realOutput = [Float](repeating: 0, count: bufferCapacity)
        let imaginaryOutput = [Float](repeating: 0, count: bufferCapacity)
        return (realOutput, imaginaryOutput)
    }

    private func computeMagnitudes(realOutput: inout [Float], imaginaryOutput: inout [Float]) -> [Float] {
        var magnitudes = [Float](repeating: 0, count: numberOfBars)

        realOutput.withUnsafeMutableBufferPointer { realBufferPointer in
            imaginaryOutput.withUnsafeMutableBufferPointer { imaginaryBufferPointer in
                var complex = DSPSplitComplex(realp: realBufferPointer.baseAddress!, imagp: imaginaryBufferPointer.baseAddress!)
                vDSP_zvabs(&complex, 1, &magnitudes, 1, UInt(numberOfBars))
            }
        }

        return magnitudes
    }

    private func normalize(magnitudes: [Float]) -> [Float] {
        var normalizedMagnitudes = [Float](repeating: 0.0, count: numberOfBars)
        var scalingFactor = Float(1)
        vDSP_vsmul(magnitudes, 1, &scalingFactor, &normalizedMagnitudes, 1, UInt(numberOfBars))
        return normalizedMagnitudes
    }
}
