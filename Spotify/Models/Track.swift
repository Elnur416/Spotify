//
//  AudioTrack.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import Foundation

// MARK: - Tracks
struct Tracks: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
    let items: [TrackItem]?
}

// MARK: - Item
struct TrackItem: Codable, HomeDataProtocol {
    let externalUrls: ExternalUrls?
    let followers: Followers?
    let genres: [String]?
    let href, id: String?
    let images: [Image]?
    let name: String?
    let popularity: Int?
    let type, uri: String?
    
    var nameText: String {
        name ?? ""
    }
    
    var imageURL: String {
        images?.first?.url ?? ""
    }

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, genres, href, id, images, name, popularity, type, uri
    }
}
