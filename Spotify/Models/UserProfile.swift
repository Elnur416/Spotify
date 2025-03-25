//
//  UserProfile.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import Foundation

struct UserProfile: Codable {
    let country: String?
    let displayName: String?
    let email: String?
    let explicitContent: [String: Bool]?
    let externalUrls: [String: String]?
    let id: String?
    let product: String?
    let images: [UserImage]?
    
    enum CodingKeys: String, CodingKey {
        case country, email, id, product
        case displayName = "display_name"
        case explicitContent = "explicit_content"
        case externalUrls = "external_urls"
        case images
    }
    
    struct UserImage: Codable {
        let url: String?
    }
}

