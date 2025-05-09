//
//  AddToPlaylistControllerViewModel.swift
//  Spotify
//
//  Created by Elnur Mammadov on 09.05.25.
//

import Foundation

final class AddToPlaylistControllerViewModel {
    private(set) var playlists = [PlaylistItem]()
    private let useCase: PlaylistUseCase
    private(set) var trackURI: String?
    
    init(useCase: PlaylistUseCase, trackURI: String) {
        self.trackURI = trackURI
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
    
    func getUserPlaylists() {
        state = .loading
        useCase.getUserPlaylists { data, error in
            if let data {
                guard let items = data.items else { return }
                self.playlists = items
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
    
    func addTrackToPlaylist(withId playlistId: String) {
        state = .loading
        useCase.addItemsToPlaylist(id: playlistId, uris: trackURI ?? "") { data, error in
            if let data {
                print(data)
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
}
