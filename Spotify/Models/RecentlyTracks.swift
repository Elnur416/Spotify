//
//  RecentlyTracks.swift
//  Spotify
//
//  Created by Elnur Mammadov on 02.04.25.
//

import Foundation

// MARK: - RecentlyTracks
struct RecentlyTracks: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let cursors: Cursors?
    let total: Int?
    let items: [RecentlyTrackItem]?
}

// MARK: - Item
struct RecentlyTrackItem: Codable, HomeDataProtocol {
    let track: Track2?
    let playedAt: String?
    let context: Context?
    
    var nameText: String {
        ""
    }
    
    var imageURL: String {
        ""
    }


    enum CodingKeys: String, CodingKey {
        case track
        case playedAt = "played_at"
        case context
    }
}

// MARK: - Context
struct Context: Codable {
    let type, href: String?
    let externalUrls: ExternalUrls?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case type, href
        case externalUrls = "external_urls"
        case uri
    }
}

// MARK: - Track
struct Track2: Codable {
    let album: Album?
    let artists: [Artist]?
    let availableMarkets: [String]?
    let discNumber, durationMS: Int?
    let explicit: Bool?
    let externalIDS: ExternalIDS?
    let externalUrls: ExternalUrls?
    let href, id: String?
    let isPlayable: Bool?
    let linkedFrom: LinkedFrom?
    let restrictions: Restrictions?
    let name: String?
    let popularity: Int?
    let previewURL: String?
    let trackNumber: Int?
    let type, uri: String?
    let isLocal: Bool?
    
    enum CodingKeys: String, CodingKey {
        case album, artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href, id
        case isPlayable = "is_playable"
        case linkedFrom = "linked_from"
        case restrictions, name, popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
        case isLocal = "is_local"
    }
}

// MARK: - Album
struct Album: Codable {
    let albumType: String?
    let totalTracks: Int?
    let availableMarkets: [String]?
    let externalUrls: ExternalUrls?
    let href, id: String?
    let images: [Image]?
    let name, releaseDate, releaseDatePrecision: String?
    let restrictions: Restrictions?
    let type, uri: String?
    let artists: [ArtistInfo]?

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

// MARK: - ExternalIDS
struct ExternalIDS: Codable {
    let isrc, ean, upc: String?
}

// MARK: - LinkedFrom
struct LinkedFrom: Codable {
}
