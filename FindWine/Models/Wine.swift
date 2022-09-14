//
//  Wine.swift
//  FindWine
//
//  Created by Маргарита Ставнийчук on 30.08.2022.
//

import Foundation

struct WineResponse: Codable {
    let results: [Wine]
}

struct Wine: Codable, Hashable {
    let title: String
    let price: Decimal
    let description: String?
    let country: String
    let available: Bool
    let imageInfo: WineImageInfo
    let url: String
    var isFavorite = false
    
    enum CodingKeys: String, CodingKey {
        case title, price, description, country
        case available = "in_stock"
        case imageInfo = "img"
        case url = "web_url"
    }
}

struct FavoriteWine: Codable, Hashable {
    let title: String
    let imageInfo: WineImageInfo
}

struct WineImageInfo: Codable, Hashable {
    let small: String
    let medium: String
    let large: String

enum CodingKeys: String, CodingKey {
  
    case small = "s150x150"
    case medium = "s200x200"
    case large = "s350x350"
  }
}
