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
    let offset: Int?
    let previous: String?
}

// MARK: - Cursors
struct Cursors: Codable {
    let after, before: String?
}

// MARK: - Item
struct ArtistInfo: Codable, ImageLabelCellProtocol, SearchDataProtocol {
    let externalUrls: ExternalUrls?
    let followers: Followers?
    let genres: [String]?
    let href, id: String?
    let images: [Image]?
    let name: String?
    let popularity: Int?
    let type, uri: String?
    
    var nameText: String {
        name ?? ""
    }
    
    var imageURL: String {
        images?.first?.url ?? ""
    }
    
    var titleName: String {
        name ?? ""
    }
    
    var followersCount: Int {
        followers?.total ?? 0
    }
    
    var itemId: String {
        id ?? ""
    }
    
    var artistName: String {
        nameText
    }
    var trackPreviewURL: String {
        ""
    }


    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, genres, href, id, images, name, popularity, type, uri
    }
}

// MARK: - ArtistTopTracks
struct ArtistTopTracks: Codable {
    let tracks: [TopTrack]?
}

// MARK: - ArtistTopTracks
struct TopTrack: Codable, TrackProtocol {
    let album: Album7?
    let artists: [Artist6]?
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
    let type: String?
    let uri: String?
    
    var mainImage: String {
        ""
    }
    
    var trackName: String {
        name ?? ""
    }
    
    var subInfo: String {
        artists?.first?.name ?? ""
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
struct Album7: Codable {
    let albumType: String?
    let artists: [Artist6]?
    let availableMarkets: [String]?
    let externalUrls: ExternalUrls?
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
struct Artist6: Codable {
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
