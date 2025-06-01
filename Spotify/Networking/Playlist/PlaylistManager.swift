//
//  PlaylistManager.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import Foundation

final class PlaylistManager: PlaylistUseCase {
    private let manager = NetworkManager()
    
    func getPlaylist(id: String) async throws -> Playlist? {
        let path = PlaylistEndpoint.playlist(id: id).path
        return try await manager.request(path: path,
                        model: Playlist.self)
    }
    
    func getUserPlaylists() async throws -> Playlists? {
        let path = UserEndpoint.userPlaylists.path
        return try await manager.request(path: path,
                        model: Playlists.self)
    }
    
    func addItemsToPlaylist(id: String, uris: String) async throws -> SnapshotResponse? {
        let path = PlaylistEndpoint.addToPlaylist(id: id).path
        let params: [String: Any] = ["uris": ["\(uris)"],
                                     "position": 0]
        return try await manager.request(path: path,
                        model: SnapshotResponse.self,
                        method: .post,
                        params: params,
                        encodingType: .json)
    }
    
    func editPlaylistName(id: String, name: String) async throws -> Empty? {
        let path = PlaylistEndpoint.editPlaylistName(id: id).path
        let params: [String: Any] = ["name": "\(name)",
                                     "description": "New playlist description",
                                     "public": false]
        return try await manager.request(path: path,
                        model: Empty.self,
                        method: .put,
                        params: params,
                        encodingType: .json)
    }
    
    func removeItemsFromPlaylist(id: String, uris: String, snapshotId: String) async throws -> SnapshotResponse? {
        let path = PlaylistEndpoint.removeFromPlaylist(id: id).path
        let params: [String: Any] = [
            "tracks": [
                ["uri": uris]
            ],
            "snapshot_id": snapshotId
        ]
        return try await manager.request(path: path,
                        model: SnapshotResponse.self,
                        method: .delete,
                        params: params,
                        encodingType: .json)
    }
}
