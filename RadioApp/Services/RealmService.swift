//
//  RealmService.swift
//  RadioApp
//
//  Created by dsm 5e on 29.07.2024.
//

import RealmSwift

final class RealmService {
    static let shared = RealmService()
    
    let realm: Realm
    
    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }
    
    func isFavorite(withID stationID: String, stations: [Station]) -> Bool {
        for station in stations {
            if station.stationuuid.contains(stationID) {
                return true
            }
        }
        return false
    }
    
    // MARK: - CRUD
    func save(_ station: Station) {
        write {
            realm.add(station)
        }
    }
    
    func fetchStations() -> Results<Station> {
        realm.objects(Station.self)
    }
    
    func delete(_ station: Station) {
        write {
            realm.delete(station)
        }
    }
    
    // MARK: - Private Methods
    private func write(completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch {
            print(error)
        }
    }
}
