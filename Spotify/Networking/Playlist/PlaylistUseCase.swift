//
//  PlaylistUseCase.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import Foundation

protocol PlaylistUseCase {
    func getPlaylist(id: String, completion: @escaping ((Playlist?, String?) -> Void))
    func getUserPlaylists(completion: @escaping((Playlists?, String?) -> Void))
    func addItemsToPlaylist(id: String, uris: String, completion: @escaping ((SnapshotResponse?, String?) -> Void))
    func editPlaylistName(id: String, name: String, completion: @escaping ((Empty?, String?) -> Void))
    func removeItemsFromPlaylist(id: String, uris: String, snapshotId: String, completion: @escaping ((SnapshotResponse?, String?) -> Void))
}
