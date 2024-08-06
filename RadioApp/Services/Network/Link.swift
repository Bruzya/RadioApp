//
//  Link.swift
//  RadioApp
//
//  Created by Evgenii Mazrukho on 04.08.2024.
//

import Foundation

enum Link {
    
    case popular
    case allStations
    case tags
    case language
    case country
    
    
    var url: String {
        switch self {
        case .popular:
            "http://all.api.radio-browser.info/json/stations?random&limit=20"
        case .allStations:
            "http://all.api.radio-browser.info/json/stations?limit=20"
        case .tags:
            "http://all.api.radio-browser.info/json/tags"
        case .language:
            "http://all.api.radio-browser.info/json/languages"
        case .country:
            "http://all.api.radio-browser.info/json/countries"
        }
    }
}
