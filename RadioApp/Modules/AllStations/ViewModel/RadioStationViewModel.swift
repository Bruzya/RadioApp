//
//  RadioStationViewModel.swift
//  RadioApp
//
//  Created by Alexander Bokhulenkov on 30.07.2024.
//

class  RadioStationViewModel {
    
    private let radioStation: RadioStation
    
    var name: String {
        return radioStation.name
    }
    
    var bitrate: Int {
        return radioStation.bitrate
    }
    
    var tag: String {
        return radioStation.tag ?? String(radioStation.bitrate)
    }
    
    var votes: Int {
        return radioStation.votes ?? 0
    }
    
    init(radioStation: RadioStation) {
        self.radioStation = radioStation
    }
    
}
