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
    case checkFollow(id: String)
    case followOrUnfollowArtist
    
    var path: String {
        switch self {
        case .artist(let id):
            return NetworkHelper.shared.configureURL(endpoint: "/artists/\(id)")
        case .topTracks(let id):
            return NetworkHelper.shared.configureURL(endpoint: "/artists/\(id)/top-tracks")
        case .checkFollow(let id):
            return NetworkHelper.shared.configureURL(endpoint: "/me/following/contains?type=artist&ids=\(id)")
        case .followOrUnfollowArtist:
            return NetworkHelper.shared.configureURL(endpoint: "/me/following?type=artist")
        }
    }
}
