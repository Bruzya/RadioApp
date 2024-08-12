//
//  Link.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 04.08.2024.
//

import Foundation

enum Link {
    
    case popular(count: Int)
    case allStations
    case tags
    case language
    case country
    case vote
    
    var url: String {
        switch self {
        case .popular(let count):
            "http://all.api.radio-browser.info/json/stations/topvote/\(count)"
        case .allStations:
            "http://all.api.radio-browser.info/json/stations?limit=20"
        case .tags:
            "http://all.api.radio-browser.info/json/tags"
        case .language:
            "http://all.api.radio-browser.info/json/languages"
        case .country:
            "http://all.api.radio-browser.info/json/countries"
        case .vote:
            "http://91.132.145.114/json/vote/"
        }
    }
}
