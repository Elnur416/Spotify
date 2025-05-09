//
//  TrackEndpoint.swift
//  Spotify
//
//  Created by Elnur Mammadov on 09.05.25.
//

import Foundation

enum TrackEndpoint {
    case saveTrack
    
    var path: String {
        switch self {
        case .saveTrack:
            return NetworkHelper.shared.configureURL(endpoint: "/me/tracks")
        }
    }
}
