//
//  PlaylistManager.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import Foundation

final class PlaylistManager: PlaylistUseCase {
    private let manager = NetworkManager()
    
    func getPlaylist(id: String, completion: @escaping (Playlist?, String?) -> Void) {
        let path = PlaylistEndpoint.playlist(id: id).path
        manager.request(path: path,
                        model: Playlist.self,
                        completion: completion)
    }
}
