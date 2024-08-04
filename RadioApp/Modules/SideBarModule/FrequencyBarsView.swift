import UIKit

final class FrequencyBarsView: UIView {
    private var pointLayers: [CAShapeLayer] = []
    private var gradientLayer: CAGradientLayer?
    private var displayLink: CADisplayLink?
    private var animationTime: CFTimeInterval = 0
    private var currentMagnitudes: [Float] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupView() {
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = [
            UIColor(red: 0.22, green: 0.32, blue: 0.63, alpha: 1.0).cgColor,
            UIColor(red: 0.60, green: 0.29, blue: 0.59, alpha: 1.0).cgColor,
            UIColor(red: 0.85, green: 0.19, blue: 0.54, alpha: 1.0).cgColor
        ]
        gradientLayer?.locations = [0.0, 0.5, 1.0]
        gradientLayer?.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer?.endPoint = CGPoint(x: 1, y: 0.5)

        if let gradientLayer = gradientLayer {
            self.layer.addSublayer(gradientLayer)
            gradientLayer.mask = CALayer()
        }

        displayLink = CADisplayLink(target: self, selector: #selector(updateAnimation))
        displayLink?.add(to: .main, forMode: .default)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = self.bounds
    }

    func updateBars(with magnitudes: [Float]) {
        guard magnitudes.count > 1 else { return }

        // Interpolate between current magnitudes and new magnitudes
        let interpolatedMagnitudes = interpolateMagnitudes(currentMagnitudes, newMagnitudes: magnitudes)
        currentMagnitudes = magnitudes

        // Remove existing point layers
        pointLayers.forEach { $0.removeFromSuperlayer() }
        pointLayers.removeAll()

        let width = self.bounds.width
        let height = self.bounds.height
        let centerY = height / 2
        let barWidth = width / CGFloat(magnitudes.count - 1)
        let pointRadius: CGFloat = 2.0 // Radius of each point
        let maxMagnitude: Float = 2.0
        let maxSpacing: CGFloat = 1 // Maximum spacing between points

        for (index, magnitude) in interpolatedMagnitudes.enumerated() {
            let x = CGFloat(index) * barWidth
            let clampedMagnitude = min(magnitude, maxMagnitude)
            let normalizedMagnitude = clampedMagnitude / maxMagnitude
            let availableHeight = CGFloat(normalizedMagnitude) * (height / 2)
            let spacing = 2 * pointRadius + maxSpacing
            let numPoints = Int(availableHeight / spacing)

            for i in 0..<numPoints {
                let yTop = centerY - CGFloat(i) * spacing
                let yBottom = centerY + CGFloat(i) * spacing

                // Create a circle path for the top point
                let pointPath = UIBezierPath(arcCenter: CGPoint(x: pointRadius, y: pointRadius), radius: pointRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)

                // Create a shape layer for the top point
                let shapeLayerTop = CAShapeLayer()
                shapeLayerTop.path = pointPath.cgPath
                shapeLayerTop.frame = CGRect(x: x - pointRadius, y: yTop - pointRadius, width: pointRadius * 2, height: pointRadius * 2)
                shapeLayerTop.fillColor = UIColor.black.cgColor

                // Create a shape layer for the bottom point
                let shapeLayerBottom = CAShapeLayer()
                shapeLayerBottom.path = pointPath.cgPath
                shapeLayerBottom.frame = CGRect(x: x - pointRadius, y: yBottom - pointRadius, width: pointRadius * 2, height: pointRadius * 2)
                shapeLayerBottom.fillColor = UIColor.black.cgColor

                // Add the shape layers to the gradient layer's mask
                self.layer.addSublayer(shapeLayerTop)
                self.layer.addSublayer(shapeLayerBottom)
                pointLayers.append(shapeLayerTop)
                pointLayers.append(shapeLayerBottom)
            }
        }

        // Mask the gradient layer with the combined shape layers
        let combinedMaskLayer = CALayer()
        pointLayers.forEach { combinedMaskLayer.addSublayer($0) }
        gradientLayer?.mask = combinedMaskLayer
    }

    private func interpolateMagnitudes(_ currentMagnitudes: [Float], newMagnitudes: [Float]) -> [Float] {
        guard currentMagnitudes.count == newMagnitudes.count else { return newMagnitudes }
        let interpolationFactor: Float = 0.1 // Adjust this value for smoother or faster interpolation
        return zip(currentMagnitudes, newMagnitudes).map { current, new in
            current + (new - current) * interpolationFactor
        }
    }

    @objc private func updateAnimation() {
        let width = self.bounds.width
        let height = self.bounds.height
        let centerY = height / 2
        let amplitude: CGFloat = 180 // Amplitude of the wave
        let frequency: CGFloat = 3 // Frequency of the wave

        for layer in pointLayers {
            let x = layer.frame.midX
            let waveOffset = amplitude * sin(frequency * x + animationTime)
            layer.frame.origin.y = centerY - layer.frame.height / 2 + waveOffset
        }

        animationTime += 0.05
    }
}
