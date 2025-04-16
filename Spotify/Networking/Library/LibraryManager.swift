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
}
