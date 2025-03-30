//
//  UserProfile.swift
//  Spotify
//
//  Created by Elnur Mammadov on 29.03.25.
//

import Foundation

enum UserEndpoint: String {
    case currentUser = "/me"
    case userPlaylists = "/me/playlists"
    
    var path: String {
        return NetworkHelper.shared.configureURL(endpoint: self.rawValue)
    }
}
