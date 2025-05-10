//
//  LibraryUseCase.swift
//  Spotify
//
//  Created by Elnur Mammadov on 16.04.25.
//

import Foundation

protocol LibraryUseCase {
    func getUserPlaylists(completion: @escaping((Playlists?, String?) -> Void))
    func getUserSavedAlbums(completion: @escaping((Albums2?, String?) -> Void))
    func getUserSavedTracks(completion: @escaping((SavedTracks?, String?) -> Void))
    func createPlaylist(name: String, userId: String, completion: @escaping((PlaylistItem?, String?) -> Void))
    func deleteAlbum(id: String, completion: @escaping((Empty?, String?) -> Void))
    func deleteTrack(id: String, completion: @escaping((Empty?, String?) -> Void))
}
