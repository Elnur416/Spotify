//
//  Playlist.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import Foundation

// MARK: - Playlists
struct Playlists: Codable {
    let href: String?
    let limit: Int?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int?
    let items: [PlaylistItem]?
}

// MARK: - Item
struct PlaylistItem: Codable, ImageLabelCellProtocol {
    let collaborative: Bool?
    let description: String?
    let externalUrls: ExternalUrls?
    let href, id: String?
    let images: [Image]?
    let name: String?
    let owner: Owner?
    let itemPublic: Bool?
    let snapshotID: String?
    let tracks: Track?
    let type, uri: String?
    
    var nameText: String {
        name ?? ""
    }
    
    var imageURL: String {
        images?.first?.url ?? ""
    }

    enum CodingKeys: String, CodingKey {
        case collaborative, description
        case externalUrls = "external_urls"
        case href, id, images, name, owner
        case itemPublic = "public"
        case snapshotID = "snapshot_id"
        case tracks, type, uri
    }
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String?
}

// MARK: - Image
struct Image: Codable {
    let url: String?
    let height, width: Int?
}

// MARK: - Owner
struct Owner: Codable {
    let externalUrls: ExternalUrls?
    let followers: Tracks?
    let href, id, type, uri: String?
    let displayName: String?

    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, href, id, type, uri
        case displayName = "display_name"
    }
}

// MARK: - Tracks
struct Track: Codable {
    let href: String?
    let total: Int?
}
