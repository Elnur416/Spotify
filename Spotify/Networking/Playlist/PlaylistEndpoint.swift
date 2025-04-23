//
//  PlaylistEndpoint.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import Foundation

enum PlaylistEndpoint {
    case playlist(id: String)
    
    var path: String {
        switch self {
        case .playlist(let id):
            return NetworkHelper.shared.configureURL(endpoint: "/playlists/\(id)")
        }
    }
}
