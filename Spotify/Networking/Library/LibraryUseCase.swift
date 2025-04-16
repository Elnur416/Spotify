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
}
