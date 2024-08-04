//
//  Station.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 04.08.2024.
//

import Foundation

struct Station: Decodable {
    let stationuuid: UUID
    let name: String
    let url: String
    let favicon: String
    let tags: String
    let country: String
    let language: String
    let votes: Int
}
