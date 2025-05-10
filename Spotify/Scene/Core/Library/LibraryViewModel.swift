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
    private(set) var tracks = [SavedTrackItem]()
    
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
        getUserSavedTracks()
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
    
    private func getUserSavedTracks() {
        self.state = .loading
        useCase.getUserSavedTracks { data, error in
            if let data {
                self.tracks = data.items ?? []
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
    
    func createPlaylist(name: String) {
        guard let userID = UserDefaults.standard.string(forKey: "userID") else { return }
        self.state = .loading
        useCase.createPlaylist(name: name,
                               userId: userID) { data, error in
            if let data {
                self.playlists.insert(data, at: 0)
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
    
    func deleteAlbumFromLibrary(id: String) {
        self.state = .loading
        useCase.deleteAlbum(id: id) { data, error in
            if data == nil {
                self.albums.removeAll { $0.itemId == id }
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
    
    func deleteTrackFromLibrary(id: String) {
        self.state = .loading
        useCase.deleteAlbum(id: id) { data, error in
            if data == nil {
                self.tracks.removeAll { $0.track?.id ?? "" == id }
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
}
