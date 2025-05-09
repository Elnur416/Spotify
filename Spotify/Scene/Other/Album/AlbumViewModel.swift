//
//  AlbumViewModel.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import Foundation

final class AlbumViewModel {
    private(set) var id: String
    private var useCase: AlbumUseCase
    private(set) var album: Album6?
    var selectedTrack: Item2?
    private var trackUseCase: TrackUseCase
    
    
    init(id: String, useCase: AlbumUseCase, trackUseCase: TrackUseCase) {
        self.id = id
        self.useCase = useCase
        self.trackUseCase = trackUseCase
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
    
    func getAlbum() {
        self.state = .loading
        useCase.getAlbum(id: id) { data, error in
            if let data {
                self.album = data
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
    
    func saveAlbum() {
        self.state = .loading
        useCase.saveAlbum(id: album?.id ?? "") { data, error in
            if data == nil {
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
    
    func saveTrackToLibrary(trackID: String) {
        self.state = .loading
        trackUseCase.saveTrack(id: trackID) { data, error in
            if data == nil {
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
}
