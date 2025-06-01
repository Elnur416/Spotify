//
//  LibraryUseCase.swift
//  Spotify
//
//  Created by Elnur Mammadov on 16.04.25.
//

import Foundation

protocol LibraryUseCase {
    func getUserPlaylists() async throws -> Playlists?
    func getUserSavedAlbums() async throws -> Albums2?
    func getUserSavedTracks() async throws -> SavedTracks?
    func createPlaylist(name: String, userId: String) async throws -> PlaylistItem?
    func deleteAlbum(id: String) async throws -> Empty?
    func deleteTrack(id: String) async throws -> Empty?
}
