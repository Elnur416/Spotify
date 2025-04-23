//
//  PlaylistUseCase.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import Foundation

protocol PlaylistUseCase {
    func getPlaylist(id: String, completion: @escaping ((Playlist?, String?) -> Void))
}
