//
//  Artist.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import Foundation

// MARK: - Artists
struct Artists: Codable {
    let artists: ArtistsClass?
}

// MARK: - ArtistsClass
struct ArtistsClass: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let cursors: Cursors?
    let total: Int?
    let items: [ArtistInfo]?
}

// MARK: - Cursors
struct Cursors: Codable {
    let after, before: String?
}

// MARK: - Item
struct ArtistInfo: Codable {
    let externalUrls: ExternalUrls?
    let followers: Followers?
    let genres: [String]?
    let href, id: String?
    let images: [Image]?
    let name: String?
    let popularity: Int?
    let type, uri: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, genres, href, id, images, name, popularity, type, uri
    }
}
