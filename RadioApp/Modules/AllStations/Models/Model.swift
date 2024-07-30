//
//  Model.swift
//  RadioApp
//
//  Created by Alexander Bokhulenkov on 29.07.2024.
//

import Foundation

struct RadioStation {
    let stationuuid: String
    let name: String
    let url: String
    let bitrate: Int
}

extension RadioStation {
    static var allStation = [
    RadioStation(stationuuid: "123", name: "first", url: "www", bitrate: 16),
    RadioStation(stationuuid: "234", name: "second", url: "www", bitrate: 28),
    RadioStation(stationuuid: "345", name: "third", url: "www", bitrate: 16),
    RadioStation(stationuuid: "565", name: "four", url: "www", bitrate: 24)
    ]
}
