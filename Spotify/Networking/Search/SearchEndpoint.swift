//
//  SearchEndpoint.swift
//  Spotify
//
//  Created by Elnur Mammadov on 06.04.25.
//

import Foundation

enum SearchEndpoint {
    case search(text: String)
    case category
    
    var path: String {
        switch self {
        case .category:
            return NetworkHelper.shared.configureURL(endpoint: "/browse/categories")
        case .search(let text):
            return NetworkHelper.shared.configureURL(endpoint: "/search?q=\(text)&type=artist%2Ctrack")
        }
    }
}
