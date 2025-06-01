//
//  LibraryManager.swift
//  Spotify
//
//  Created by Elnur Mammadov on 16.04.25.
//

import Foundation

final class LibraryManager: LibraryUseCase {
    private let manager = NetworkManager()
    
    func getUserPlaylists() async throws -> Playlists? {
        let path = LibraryEndpoint.playlist.path
        return try await manager.request(path: path,
                        model: Playlists.self)
    }
    
    func getUserSavedAlbums() async throws -> Albums2? {
        let path = LibraryEndpoint.album.path
        return try await manager.request(path: path,
                        model: Albums2.self)
    }
    
    func getUserSavedTracks() async throws -> SavedTracks? {
        let path = LibraryEndpoint.track.path
        return try await manager.request(path: path,
                        model: SavedTracks.self)
    }
    
    func createPlaylist(name: String, userId: String) async throws -> PlaylistItem? {
        let path = LibraryEndpoint.createPlaylist(id: userId).path
        let params: [String: Any] = ["name": "\(name)",
                                     "description": "New playlist description",
                                     "public": false]
        return try await manager.request(path: path,
                        model: PlaylistItem.self,
                        method: .post,
                        params: params,
                        encodingType: .json)
    }
    
    func deleteAlbum(id: String) async throws -> Empty? {
        let path = LibraryEndpoint.deleteAlbum.path
        let params: [String: Any] = ["ids": [
            "\(id)"
        ]]
        return try await manager.request(path: path,
                        model: Empty.self,
                        method: .delete,
                        params: params,
                        encodingType: .json)
    }
    
    func deleteTrack(id: String) async throws -> Empty? {
        let path = LibraryEndpoint.deleteTrack.path
        let params: [String: Any] = ["ids": [
            "\(id)"
        ]]
        return try await manager.request(path: path,
                        model: Empty.self,
                        method: .delete,
                        params: params,
                        encodingType: .json)
    }
}
