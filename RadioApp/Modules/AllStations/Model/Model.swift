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
    let tag: String?
    let votes: Int?
}

//"tags":"jazz,pop,rock,indie"
