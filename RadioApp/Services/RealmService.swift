//
//  RealmService.swift
//  RadioApp
//
//  Created by dsm 5e on 29.07.2024.
//

import RealmSwift

final class RealmService {

    private var realm: Realm {
        do {
            return try Realm()
        } catch {
            fatalError("Error initializing Realm: \(error.localizedDescription)")
        }
    }

    // MARK: - Favorites

    func saveToFavorites<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            print("Error saving to favorites: \(error.localizedDescription)")
        }
    }

    func removeFromFavorites<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Error removing from favorites: \(error.localizedDescription)")
        }
    }

    func getFavorites<T: Object>(_ type: T.Type) -> Results<T> {
        return realm.objects(type)
    }
}
