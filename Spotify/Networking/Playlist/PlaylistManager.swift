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
    
    func getUserPlaylists(completion: @escaping ((Playlists?, String?) -> Void)) {
        let path = UserEndpoint.userPlaylists.path
        manager.request(path: path,
                        model: Playlists.self,
                        completion: completion)
    }
    
    func addItemsToPlaylist(id: String, uris: String, completion: @escaping (SnapshotResponse?, String?) -> Void) {
        let path = PlaylistEndpoint.addToPlaylist(id: id).path
        let params: [String: Any] = ["uris": ["\(uris)"],
                                     "position": 0]
        manager.request(path: path,
                        model: SnapshotResponse.self,
                        method: .post,
                        params: params,
                        encodingType: .json,
                        completion: completion)
    }
}
