//
//  Album.swift
//  Spotify
//
//  Created by Elnur Mammadov on 01.04.25.
//

import Foundation

// MARK: - Albums
struct Albums: Codable {
    let albums: AlbumsClass?
}

// MARK: - AlbumsClass
struct AlbumsClass: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
    let items: [AlbumItem]?
}

// MARK: - Item
struct AlbumItem: Codable, ImageLabelCellProtocol {
    let albumType: String?
    let totalTracks: Int?
    let availableMarkets: [String]?
    let externalUrls: ExternalUrls?
    let href, id: String?
    let images: [Image]?
    let name, releaseDate, releaseDatePrecision: String?
    let restrictions: Restrictions?
    let type, uri: String?
    let artists: [Artist]?
    
    var nameText: String {
        name ?? ""
    }
    
    var imageURL: String {
        images?.first?.url ?? ""
    }
    
    var itemId: String {
        id ?? ""
    }

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case totalTracks = "total_tracks"
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case restrictions, type, uri, artists
    }
}

// MARK: - Artist
struct Artist: Codable {
    let externalUrls: ExternalUrls?
    let href, id, name, type: String?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, name, type, uri
    }
}

// MARK: - Restrictions
struct Restrictions: Codable {
    let reason: String?
}
