//
//  LibraryManager.swift
//  Spotify
//
//  Created by Elnur Mammadov on 16.04.25.
//

import Foundation

final class LibraryManager: LibraryUseCase {
    private let manager = NetworkManager()
    
    func getUserPlaylists(completion: @escaping (Playlists?, String?) -> Void) {
        let path = LibraryEndpoint.playlist.path
        manager.request(path: path,
                        model: Playlists.self,
                        completion: completion)
    }
    
    func getUserSavedAlbums(completion: @escaping (Albums2?, String?) -> Void) {
        let path = LibraryEndpoint.album.path
        manager.request(path: path,
                        model: Albums2.self,
                        completion: completion)
    }
    
    func getUserSavedTracks(completion: @escaping (SavedTracks?, String?) -> Void) {
        let path = LibraryEndpoint.track.path
        manager.request(path: path,
                        model: SavedTracks.self,
                        completion: completion)
    }
    
    func createPlaylist(name: String, userId: String, completion: @escaping((PlaylistItem?, String?) -> Void)) {
        let path = LibraryEndpoint.createPlaylist(id: userId).path
        let params: [String: Any] = ["name": "\(name)",
                                     "description": "New playlist description",
                                     "public": false]
        manager.request(path: path,
                        model: PlaylistItem.self,
                        method: .post,
                        params: params,
                        encodingType: .json,
                        completion: completion)
    }
    
    func deleteAlbum(id: String, completion: @escaping((Empty?, String?) -> Void)) {
        let path = LibraryEndpoint.deleteAlbum.path
        let params: [String: Any] = ["ids": [
            "\(id)"
        ]]
        manager.request(path: path,
                        model: Empty.self,
                        method: .delete,
                        params: params,
                        encodingType: .json,
                        completion: completion)
    }
    
    func deleteTrack(id: String, completion: @escaping((Empty?, String?) -> Void)) {
        let path = LibraryEndpoint.deleteTrack.path
        let params: [String: Any] = ["ids": [
            "\(id)"
        ]]
        manager.request(path: path,
                        model: Empty.self,
                        method: .delete,
                        params: params,
                        encodingType: .json,
                        completion: completion)
    }
}
