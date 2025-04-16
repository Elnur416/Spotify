//
//  LibraryViewModel.swift
//  Spotify
//
//  Created by Elnur Mammadov on 16.04.25.
//

import Foundation

final class LibraryViewModel {
    private let useCase: LibraryUseCase
    var section: LibrarySectionNames? = .playlists
    private(set) var playlists = [PlaylistItem]()
    private(set) var albums = [AlbumsItem]()
    
    init(useCase: LibraryUseCase) {
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
    
    func getAllData() {
        getUserPLaylists()
        getUserSavedAlbums()
    }
    
    private func getUserPLaylists() {
        self.state = .loading
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
    
    private func getUserSavedAlbums() {
        self.state = .loading
        useCase.getUserSavedAlbums { data, error in
            if let data {
                guard let items = data.items else { return }
                self.albums = items
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
}
