//
//  ArtistEndpoint.swift
//  Spotify
//
//  Created by Elnur Mammadov on 23.04.25.
//

import Foundation

enum ArtistEndpoint {
    case artist(id: String)
    case topTracks(id: String)
    
    var path: String {
        switch self {
        case .artist(let id):
            return NetworkHelper.shared.configureURL(endpoint: "/artists/\(id)")
        case .topTracks(let id):
            return NetworkHelper.shared.configureURL(endpoint: "/artists/\(id)/top-tracks")
        }
    }
}
