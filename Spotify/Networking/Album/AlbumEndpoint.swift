//
//  AlbumEndpoint.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import Foundation

enum AlbumEndpoint {
    case album(id: String)
    
    var path: String {
        switch self {
        case .album(let id):
            return NetworkHelper.shared.configureURL(endpoint: "/albums/\(id)")
        }
    }
}
