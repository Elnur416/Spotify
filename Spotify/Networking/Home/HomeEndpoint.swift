//
//  HomeEndpoint.swift
//  Spotify
//
//  Created by Elnur Mammadov on 01.04.25.
//

import Foundation

enum HomeEndpoint: String {
    case newReleases = "/browse/new-releases"
    case tracks = "/me/top/tracks"
    case artists = "/me/top/artists"
    case recentlyTracks = "/me/player/recently-played?limit=8"
    
    var path: String {
        return NetworkHelper.shared.configureURL(endpoint: self.rawValue)
    }
}
