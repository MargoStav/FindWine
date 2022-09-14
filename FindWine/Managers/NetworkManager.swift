//
//  NetworkManager.swift
//  FindWine
//
//  Created by Маргарита Ставнийчук on 30.08.2022.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://stores-api.zakaz.md/stores/48415602/categories/wine/products"
    
    
    func getWineInfo(completed: @escaping (Result<[Wine], FWError>) -> Void) {
        let endpoint = baseURL
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidWineName))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let wines = try decoder.decode(WineResponse.self, from: data)
                completed(.success(wines.results))
            } catch {
                completed(.failure(.invalidData))
            }
       }
        task.resume()
    }
}
