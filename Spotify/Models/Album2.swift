//
//  Album2.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import Foundation

// MARK: - Playlist
struct Album6: Codable, HeaderProtocol {
    let albumType: String?
    let totalTracks: Int?
    let availableMarkets: [String]?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let images: [Image]?
    let name, releaseDate, releaseDatePrecision, type: String?
    let uri: String?
    let artists: [Artist]?
    let tracks: Tracks5?
    let copyrights: [Copyright]?
    let externalIDS: ExternalIDS2?
    let genres: [String]?
    let label: String?
    let popularity: Int?
    
    var mainImage: String {
        images?.first?.url ?? ""
    }
    
    var titleName: String {
        name ?? ""
    }
    
    var ownerName: String {
        artists?.first?.name ?? ""
    }
    
    var totalTracksCount: Int {
        tracks?.items?.count ?? 0
    }

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

// MARK: - ExternalIDS
struct ExternalIDS2: Codable {
    let upc: String?
}

// MARK: - Tracks
struct Tracks5: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
    let items: [Item2]?
}

// MARK: - Item
struct Item2: Codable {
    let artists: [Artist]?
    let availableMarkets: [String]?
    let discNumber, durationMS: Int?
    let explicit: Bool?
    let externalUrls: ExternalUrls?
    let href: String?
    let id, name: String?
    let previewURL: String?
    let trackNumber: Int?
    let type, uri: String?
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
