//
//  kaecfa.swift
//  Spotify
//
//  Created by Elnur Mammadov on 16.04.25.
//

import Foundation

// MARK: - Albums
struct Albums2: Codable {
    let href: String?
    let items: [AlbumsItem]?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
}

// MARK: - AlbumsItem
struct AlbumsItem: Codable, ImageLabelCellProtocol {
    let addedAt: String?
    let album: Album5?
    
    var nameText: String {
        album?.name ?? ""
    }
    
    var imageURL: String {
        album?.images?.first?.url ?? ""
    }

    enum CodingKeys: String, CodingKey {
        case addedAt = "added_at"
        case album
    }
}

// MARK: - Album
struct Album5: Codable {
    let albumType: String?
    let totalTracks: Int?
    let availableMarkets: [String]?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let images: [Image]?
    let name, releaseDate, releaseDatePrecision, type: String?
    let uri: String?
    let artists: [Artist5]?
    let tracks: Tracks3?
    let copyrights: [Copyright]?
    let externalIDS: [String: String]?
    let genres: [String]?
    let label: String?
    let popularity: Int?

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case totalTracks = "total_tracks"
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case type, uri, artists, tracks, copyrights
        case externalIDS = "external_ids"
        case genres, label, popularity
    }
}

// MARK: - Artist
struct Artist5: Codable {
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let name: Name?
    let type: ArtistType?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, name, type, uri
    }
}

enum Name: String, Codable {
    case mcFabinhoDaOsk = "MC Fabinho da Osk"
    case nxght = "NXGHT!"
    case scythermane = "Scythermane"
    case sıfırKM = "Sıfır Km"
}

enum ArtistType: String, Codable {
    case artist = "artist"
}

// MARK: - Copyright
struct Copyright: Codable {
    let text, type: String?
}

// MARK: - Tracks
struct Tracks3: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
    let items: [TracksItem2]?
}

// MARK: - TracksItem
struct TracksItem2: Codable {
    let artists: [Artist5]?
    let availableMarkets: [String]?
    let discNumber, durationMS: Int?
    let explicit: Bool?
    let externalUrls: ExternalUrls?
    let href: String?
    let id, name: String?
    let previewURL: String?
    let trackNumber: Int?
    let type: ItemType?
    let uri: String?
    let isLocal: Bool?

    enum CodingKeys: String, CodingKey {
        case artists
        case availableMarkets = "available_markets"
        case discNumber = "disc_number"
        case durationMS = "duration_ms"
        case explicit
        case externalUrls = "external_urls"
        case href, id, name
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
        case isLocal = "is_local"
    }
}

enum ItemType: String, Codable {
    case track = "track"
}
