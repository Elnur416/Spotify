//
//  PlaylistEndpoint.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import Foundation

enum PlaylistEndpoint {
    case playlist(id: String)
    case userPlaylists
    case addToPlaylist(id: String)
    case editPlaylistName(id: String)
    case removeFromPlaylist(id: String)
    
    var path: String {
        switch self {
        case .playlist(let id):
            return NetworkHelper.shared.configureURL(endpoint: "/playlists/\(id)")
        case .userPlaylists:
            return NetworkHelper.shared.configureURL(endpoint: "/me/playlists")
        case .addToPlaylist(let id):
            return NetworkHelper.shared.configureURL(endpoint: "/playlists/\(id)/tracks")
        case .editPlaylistName(let id):
            return NetworkHelper.shared.configureURL(endpoint: "/playlists/\(id)")
        case .removeFromPlaylist(let id):
            return NetworkHelper.shared.configureURL(endpoint: "/playlists/\(id)/tracks")
        }
    }
}
