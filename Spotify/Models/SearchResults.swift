//
//  SearchResults.swift
//  Spotify
//
//  Created by Elnur Mammadov on 06.04.25.
//

import Foundation

// MARK: - SearchResults
struct SearchResults: Codable {
    let tracks: Tracks3?
    let artists: Artists3?
    let albums: Albums3?
    let playlists: Playlists3?
}

// MARK: - Albums
struct Albums3: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
    let items: [AlbumElement]?
}

// MARK: - AlbumElement
struct AlbumElement: Codable {
    let albumType: AlbumTypeEnum2?
    let totalTracks: Int?
    let availableMarkets: [String]?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let images: [Image]?
    let name, releaseDate: String?
    let releaseDatePrecision: ReleaseDatePrecision?
    let type: AlbumTypeEnum2?
    let uri: String?
    let artists: [Artist4]?
    let isPlayable: Bool?

    enum CodingKeys: String, CodingKey {
        case albumType = "album_type"
        case totalTracks = "total_tracks"
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case releaseDatePrecision = "release_date_precision"
        case type, uri, artists
        case isPlayable = "is_playable"
    }
}

enum AlbumTypeEnum2: String, Codable {
    case album = "album"
    case single = "single"
}

// MARK: - Artist
struct Artist4: Codable {
    let externalUrls: ExternalUrls?
    let href: String?
    let id, name: String?
    let type: ArtistType?
    let uri, displayName: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case href, id, name, type, uri
        case displayName = "display_name"
    }
}

enum ArtistType: String, Codable {
    case artist = "artist"
    case user = "user"
}

enum ReleaseDatePrecision: String, Codable {
    case day = "day"
}

// MARK: - Artists
struct Artists3: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
    let items: [ArtistsItem]?
}

// MARK: - ArtistsItem
struct ArtistsItem: Codable {
    let externalUrls: ExternalUrls?
    let followers: Followers2?
    let genres: [String]?
    let href: String?
    let id: String?
    let images: [Image]?
    let name: String?
    let popularity: Int?
    let type: ArtistType?
    let uri: String?

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

// MARK: - Playlists
struct Playlists3: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
    let items: [PlaylistsItem?]?
}

// MARK: - PlaylistsItem
struct PlaylistsItem: Codable {
    let collaborative: Bool?
    let description: String?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let images: [Image]?
    let name: String?
    let owner: Artist4?
    let primaryColor: String?
    let itemPublic: Bool?
    let snapshotID: String?
    let tracks: Followers2?
    let type, uri: String?

    enum CodingKeys: String, CodingKey {
        case collaborative, description
        case externalUrls = "external_urls"
        case href, id, images, name, owner
        case primaryColor = "primary_color"
        case itemPublic = "public"
        case snapshotID = "snapshot_id"
        case tracks, type, uri
    }
}

// MARK: - Tracks
struct Tracks3: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
    let items: [TracksItem]?
}

// MARK: - TracksItem
struct TracksItem: Codable {
    let album: AlbumElement?
    let artists: [Artist4]?
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
    let type: PurpleType?
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
        case isPlayable = "is_playable"
        case name, popularity
        case previewURL = "preview_url"
        case trackNumber = "track_number"
        case type, uri
    }
}

enum PurpleType: String, Codable {
    case track = "track"
}
