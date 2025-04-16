//
//  SearchResults.swift
//  Spotify
//
//  Created by Elnur Mammadov on 06.04.25.
//

import Foundation

// MARK: - SearchResults
struct SearchResults: Codable {
    let tracks: Tracks2?
    let artists: Artists2?
}

// MARK: - Artists
struct Artists2: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
    let items: [ArtistsItem]?
}

// MARK: - ArtistsItem
struct ArtistsItem: Codable, SearchDataProtocol {
    let externalUrls: [String: String]
    let followers: Followers2?
    let genres: [String]?
    let href: String?
    let id: String?
    let images: [Image]?
    let name: String?
    let popularity: Int?
    let type: String?
    let uri: String?
    
    var titleName: String {
        name ?? ""
    }
    
    var imageURL: String {
        images?.first?.url ?? ""
    }
    
    var followersCount: Int {
        followers?.total ?? 0
    }

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, genres, href, id, images, name, popularity, type, uri
    }
}

// MARK: - Followers
struct Followers2: Codable {
    let href: String?
    let total: Int?
}

// MARK: - Tracks
struct Tracks2: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
    let items: [TracksItem]?
}

// MARK: - TracksItem
struct TracksItem: Codable, SearchDataProtocol {
    let album: Album3?
    let artists: [Artist4]?
    let availableMarkets: [String]?
    let discNumber, durationMS: Int?
    let explicit: Bool?
    let externalIDS: [String: String]?
    let externalUrls: [String: String]?
    let href: String?
    let id: String?
    let isLocal, isPlayable: Bool?
    let name: String?
    let popularity: Int?
    let previewURL: String?
    let trackNumber: Int?
    let type: String?
    let uri: String?
    
    var titleName: String {
        name ?? ""
    }
    
    var imageURL: String {
        album?.images?.first?.url ?? ""
    }
    
    var followersCount: Int {
        popularity ?? 0
    }

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
        case isPlayable = "is_playable"
        case name, popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
    }
}

// MARK: - Album
struct Album3: Codable {
    let albumType: String?
    let artists: [Artist4]?
    let availableMarkets: [String]?
    let externalUrls: [String: String]?
    let href: String?
    let id: String?
    let images: [Image]?
    let isPlayable: Bool?
    let name, releaseDate: String?
    let releaseDatePrecision: String?
    let totalTracks: Int?
    let type: String?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case artists
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images
        case isPlayable = "is_playable"
        case name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case totalTracks = "total_tracks"
        case type, uri
    }
}

// MARK: - Artist
struct Artist4: Codable {
    let externalUrls: [String: String]?
    let href: String?
    let id, name: String?
    let type: String?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, name, type, uri
    }
}

enum PurpleType: String, Codable {
    case track = "track"
}
