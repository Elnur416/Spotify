//
//  UserProfile.swift
//  Spotify
//
//  Created by Elnur Mammadov on 29.03.25.
//

import Foundation

enum UserEndpoint: String {
    case currentUser = "/me"
    
    var path: String {
        return NetworkHelper.shared.baseAPIURL + self.rawValue
    }
}
