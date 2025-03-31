//
//  PlaylistsListViewModel.swift
//  Spotify
//
//  Created by Elnur Mammadov on 31.03.25.
//

import Foundation

final class PlaylistsListViewModel {
    var playLists: [PlaylistItem]
    
    init(playLists: [PlaylistItem]) {
        self.playLists = playLists
    }
}
