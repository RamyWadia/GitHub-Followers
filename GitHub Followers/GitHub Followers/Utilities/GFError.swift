//
//  GFError.swift
//  GitHub Followers
//
//  Created by Ramy Atalla on 2020-03-04.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    
    case invalidUserName    = "This username created invalid request, Please try again."
    case unableToComplete   = "Unable to complete your request please check your internet connection."
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid, please try again"
    case unableToFavorite   = "This user can not be added to favorites"
    case alreadyInFavorites = "This user is already in favorites"
}
