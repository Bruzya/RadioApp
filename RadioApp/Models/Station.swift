//
//  Station.swift
//  RadioApp
//
//  Created by Vladimir Dmitriev on 04.08.24.
//

import RealmSwift

final class Station: Object, Decodable {
    @Persisted var stationuuid = ""
    @Persisted var name = ""
    @Persisted var url = ""
    @Persisted var favicon = ""
    @Persisted var tags = ""
    @Persisted var country = ""
    @Persisted var language = ""
    @Persisted var votes = 0
    
    convenience init(
        stationuuid: String,
        name: String,
        url: String,
        favicon: String,
        tags: String,
        country: String,
        language: String,
        votes: Int
    ) {
        self.init()
        self.stationuuid = stationuuid
        self.name = name
        self.url = url
        self.favicon = favicon
        self.tags = tags
        self.country = country
        self.language = language
        self.votes = votes
    }
}

