//
//  RecentlyTracks.swift
//  Spotify
//
//  Created by Elnur Mammadov on 02.04.25.
//

import Foundation

// MARK: - RecentlyTracks
struct RecentlyTracks: Codable {
    let items: [RecentItem]?
    let next: String?
    let cursors: Cursors2?
    let limit: Int?
    let href: String?
}

// MARK: - Cursors
struct Cursors2: Codable {
    let after, before: String?
}

// MARK: - Item
struct RecentItem: Codable {
    let track: Track2?
    let playedAt: String?
    let context: Context?

    enum CodingKeys: String, CodingKey {
        case track
        case playedAt = "played_at"
        case context
    }
}

// MARK: - Context
struct Context: Codable {
    let href: String?
    let externalUrls: ExternalUrls2?
    let type, uri: String?

    enum CodingKeys: String, CodingKey {
        case href
        case externalUrls = "external_urls"
        case type, uri
    }
}

// MARK: - ExternalUrls
struct ExternalUrls2: Codable {
    let spotify: String?
}

// MARK: - Track
struct Track2: Codable {
    let album: Album2?
    let artists: [Artist]?
    let availableMarkets: [String]?
    let discNumber, durationMS: Int?
    let explicit: Bool?
    let externalIDS: ExternalIDS?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let isLocal: Bool?
    let name: String?
    let popularity: Int?
    let previewURL: String?
    let trackNumber: Int?
    let type: TrackType?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case album, artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href, id
        case isLocal = "is_local"
        case name, popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
    }
}

// MARK: - Album
struct Album2: Codable {
    let albumType: AlbumTypeEnum?
    let artists: [Artist]?
    let availableMarkets: [String]?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let images: [Image2]?
    let name, releaseDate: String?
    let releaseDatePrecision: String?
    let totalTracks: Int?
    let type: AlbumTypeEnum?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case type, uri
    }
}

enum AlbumTypeEnum: String, Codable {
    case album = "album"
    case single = "single"
}

// MARK: - Artist
struct Artist2: Codable {
    let externalUrls: ExternalUrls?
    let href: String?
    let id, name: String?
    let type: String?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, name, type, uri
    }
}

// MARK: - Image
struct Image2: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}

// MARK: - ExternalIDS
struct ExternalIDS: Codable {
    let isrc: String?
}

enum TrackType: String, Codable {
    case track = "track"
}
