//
//  SavedTracks.swift
//  Spotify
//
//  Created by Elnur Mammadov on 09.05.25.
//

import Foundation

// MARK: - SavedTracks
struct SavedTracks: Codable {
    let href: String?
    let items: [SavedTrackItem]?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
}

// MARK: - Item
struct SavedTrackItem: Codable {
    let addedAt: String?
    let track: Track4?

    enum CodingKeys: String, CodingKey {
        case addedAt = "added_at"
        case track
    }
}

// MARK: - Track
struct Track4: Codable, ImageLabelCellProtocol {
    let album: Album8?
    let artists: [Artist7]?
    let availableMarkets: [String]?
    let discNumber, durationMS: Int?
    let explicit: Bool?
    let externalIDS: ExternalIDS?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let isLocal, isPlayable: Bool?
    let name: String?
    let popularity: Int?
    let previewURL: String?
    let trackNumber: Int?
    let type: TrackType?
    let uri: String?
    
    var nameText: String {
        name ?? ""
    }
    
    var imageURL: String {
        album?.images?.first?.url ?? ""
    }
    
    var itemId: String {
        id ?? ""
    }
    
    var artistName: String {
        artists?.first?.name ?? ""
    }
    
    var trackPreviewURL: String {
        previewURL ?? ""
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
struct Album8: Codable {
    let albumType: AlbumTypeEnum?
    let artists: [Artist7]?
    let availableMarkets: [String]?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let images: [Image]?
    let isPlayable: Bool?
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
struct Artist7: Codable {
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
