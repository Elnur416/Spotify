//
//  LibraryEndpoint.swift
//  Spotify
//
//  Created by Elnur Mammadov on 16.04.25.
//

import Foundation

enum LibraryEndpoint {
    case playlist
    case album
    case track
    case createPlaylist(id: String)
    case deleteAlbum
    case deleteTrack
    
    var path: String {
        switch self {
        case .playlist:
            return NetworkHelper.shared.configureURL(endpoint: "/me/playlists")
        case .album:
            return NetworkHelper.shared.configureURL(endpoint: "/me/albums")
        case .track:
            return NetworkHelper.shared.configureURL(endpoint: "/me/tracks")
        case .createPlaylist(let id):
            return NetworkHelper.shared.configureURL(endpoint: "/users/\(id)/playlists")
        case .deleteAlbum:
            return NetworkHelper.shared.configureURL(endpoint: "/me/albums")
        case .deleteTrack:
            return NetworkHelper.shared.configureURL(endpoint: "/me/tracks")
        }
    }
}
