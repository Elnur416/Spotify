//
//  AlbumEndpoint.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import Foundation

enum AlbumEndpoint {
    case album(id: String)
    case saveAlbum
    
    var path: String {
        switch self {
        case .album(let id):
            return NetworkHelper.shared.configureURL(endpoint: "/albums/\(id)")
        case .saveAlbum:
            return NetworkHelper.shared.configureURL(endpoint: "/me/albums")
        }
    }
}
