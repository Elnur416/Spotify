//
//  PlaylistViewModel.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import Foundation

final class PlaylistViewModel {
    private(set) var playlistID: String
    private var useCase: PlaylistUseCase
    private(set) var playlist: Playlist?
    
    init(playlistID: String, useCase: PlaylistUseCase) {
        self.playlistID = playlistID
        self.useCase = useCase
    }
    
    enum ViewState {
        case loading
        case loaded
        case success
        case error(String)
        case idle
    }
    
    var stateUpdated: ((ViewState) -> Void)?
    
    var state: ViewState = .idle {
        didSet {
            stateUpdated?(state)
        }
    }
    
    func getPlaylist() {
        self.state = .loading
        useCase.getPlaylist(id: playlistID) { data, error in
            if let data {
                self.playlist = data
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
}
