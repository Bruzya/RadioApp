//
//  RadioStationViewModel.swift
//  RadioApp
//
//  Created by Alexander Bokhulenkov on 30.07.2024.
//

final class  RadioStationViewModel {
    
    private let radioStation: Station
    
    var name: String {
        let originalSting = radioStation.name
        let newString = String(originalSting.dropFirst())
        return newString
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
