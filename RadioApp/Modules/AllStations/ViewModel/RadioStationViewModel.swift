//
//  RadioStationViewModel.swift
//  RadioApp
//
//  Created by Alexander Bokhulenkov on 30.07.2024.
//

final class  RadioStationViewModel {
    
    private let radioStation: Station
    
    var name: String {
        return radioStation.name
    }
    
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
