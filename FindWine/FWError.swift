//
//  FWError.swift
//  FindWine
//
//  Created by Маргарита Ставнийчук on 30.08.2022.
//

import Foundation

enum FWError: String, Error {
    
    case invalidWineName = "This wine name created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this wine. Please try again."
    case alreadyInFavorites = "You've already favorited this wine."
}
