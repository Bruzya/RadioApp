//
//  RadioStationListVM.swift
//  RadioApp
//
//  Created by Alexander Bokhulenkov on 30.07.2024.
//

import UIKit

class RadioStationListVM {
      var radioStation: [RadioStation] = [
        RadioStation(stationuuid: "123", name: "first", url: "www", bitrate: 16, tag: "16", votes: 2),
        RadioStation(stationuuid: "234", name: "second", url: "www", bitrate: 28, tag: "Rock", votes: 10),
        RadioStation(stationuuid: "345", name: "third", url: "www", bitrate: 16, tag: "Pop", votes: 5),
        RadioStation(stationuuid: "565", name: "four", url: "www", bitrate: 24, tag: "24", votes: 24)
    ]
    
    var numberOfStations: Int {
        return radioStation.count
    }
    
//   добавить получение данных из сети с радиостанциями для заполнения массива
    
    func radioStationViewModel(at index: Int) -> RadioStationViewModel {
        return RadioStationViewModel(radioStation: radioStation[index])
    }
    
}
