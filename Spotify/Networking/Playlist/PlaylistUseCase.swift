//
//  PlaylistUseCase.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import Foundation

protocol PlaylistUseCase {
    func getPlaylist(id: String) async throws -> Playlist?
    func getUserPlaylists() async throws -> Playlists?
    func addItemsToPlaylist(id: String, uris: String) async throws -> SnapshotResponse?
    func editPlaylistName(id: String, name: String) async throws -> Empty?
    func removeItemsFromPlaylist(id: String, uris: String, snapshotId: String) async throws -> SnapshotResponse?
}
