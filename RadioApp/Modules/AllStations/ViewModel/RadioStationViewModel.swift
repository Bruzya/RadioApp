//
//  RadioStationViewModel.swift
//  RadioApp
//
//  Created by Alexander Bokhulenkov on 30.07.2024.
//

class  RadioStationViewModel {
    
    private let radioStation: Station
    
    var name: String {
        return radioStation.name
    }
    
//    var bitrate: Int {
//        return radioStation.bitrate
//    }
    
    var tag: String {
        return radioStation.tags
    }
    
    var votes: Int {
        return radioStation.votes
    }
    
    init(radioStation: Station) {
        self.radioStation = radioStation
    }
    
}
