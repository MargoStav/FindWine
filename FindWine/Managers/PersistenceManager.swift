//
//  PersistenceManager.swift
//  FindWine
//
//  Created by Маргарита Ставнийчук on 13.09.2022.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys { static let favorites = "favorites"}
    
    static func updateWith(favorite: FavoriteWine, actionType: PersistenceActionType, completed: @escaping (FWError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case.success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll { $0.title == favorite.title }
                }
                completed(save(favorites: favorites))
                
            case.failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[FavoriteWine], FWError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([FavoriteWine].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [FavoriteWine]) -> FWError? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return.unableToFavorite
        }
    }
}
