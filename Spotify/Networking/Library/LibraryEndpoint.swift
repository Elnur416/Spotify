//
//  LibraryEndpoint.swift
//  Spotify
//
//  Created by Elnur Mammadov on 16.04.25.
//

import Foundation

enum LibraryEndpoint: String {
    case playlist = "/me/playlists"
    case album = "/me/albums"
    
    var path: String {
        switch self {
        case .playlist:
            return NetworkHelper.shared.configureURL(endpoint: self.rawValue)
        case .album:
            return NetworkHelper.shared.configureURL(endpoint: self.rawValue)
        }
    }
}
