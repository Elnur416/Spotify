//
//  Playlist2.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import Foundation

// MARK: - Playlist
struct Playlist: Codable, HeaderProtocol {
    let collaborative: Bool?
    let description: String?
    let externalUrls: ExternalUrls?
    let followers: Followers?
    let href: String?
    let id: String?
    let images: [Image]?
    let name: String?
    let owner: Owner2?
    let primaryColor: String?
    let playlistPublic: Bool?
    var snapshotID: String?
    var tracks: Tracks4?
    let type, uri: String?
    
    var mainImage: String {
        images?.first?.url ?? ""
    }
    
    var titleName: String {
        name ?? ""
    }
    
    var ownerName: String {
        owner?.displayName ?? ""
    }
    
    var totalTracksCount: Int {
        Int(tracks?.total ?? 0)
    }
    

    enum CodingKeys: String, CodingKey {
        case collaborative, description
        case externalUrls = "external_urls"
        case followers, href, id, images, name, owner
        case primaryColor = "primary_color"
        case playlistPublic = "public"
        case snapshotID = "snapshot_id"
        case tracks, type, uri
    }
}

// MARK: - Owner
struct Owner2: Codable {
    let displayName: String?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let type: String?
    let uri, name: String?

    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case externalUrls = "external_urls"
        case href, id, type, uri, name
    }
}

// MARK: - Tracks
struct Tracks4: Codable {
    let href: String?
    var items: [Item]?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
}

// MARK: - Item
struct Item: Codable {
    let addedAt: String?
    let addedBy: Owner2?
    let isLocal: Bool?
    let primaryColor: String?
    let track: Track3?
    let videoThumbnail: VideoThumbnail?

    enum CodingKeys: String, CodingKey {
        case addedAt = "added_at"
        case addedBy = "added_by"
        case isLocal = "is_local"
        case primaryColor = "primary_color"
        case track
        case videoThumbnail = "video_thumbnail"
    }
}

// MARK: - Track
struct Track3: Codable {
    let previewURL: String?
    let availableMarkets: [String]?
    let explicit: Bool?
    let type: String?
    let episode, track: Bool?
    let album: Album4?
    let artists: [Owner2]?
    let discNumber, trackNumber, durationMS: Int?
    let externalIDS: ExternalIDS?
    let externalUrls: ExternalUrls?
    let href: String?
    let id, name: String?
    let popularity: Int?
    let uri: String?
    let isLocal: Bool?
    
    enum CodingKeys: String, CodingKey {
        case previewURL = "preview_url"
        case availableMarkets = "available_markets"
        case explicit, type, episode, track, album, artists
        case discNumber = "disc_number"
        case trackNumber = "track_number"
        case durationMS = "duration_ms"
        case externalIDS = "external_ids"
        case externalUrls = "external_urls"
        case href, id, name, popularity, uri
        case isLocal = "is_local"
    }
}

// MARK: - Album
struct Album4: Codable {
    let availableMarkets: [String]?
    let type, albumType: String?
    let href: String?
    let id: String?
    let images: [Image]?
    let name, releaseDate, releaseDatePrecision, uri: String?
    let artists: [Owner2]?
    let externalUrls: ExternalUrls?
    let totalTracks: Int?

    enum CodingKeys: String, CodingKey {
        case availableMarkets = "available_markets"
        case type
        case albumType = "album_type"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case uri, artists
        case externalUrls = "external_urls"
        case totalTracks = "total_tracks"
    }
}

// MARK: - VideoThumbnail
struct VideoThumbnail: Codable {
    let url: String?
}
