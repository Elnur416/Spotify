//
//  ArtistViewModel.swift
//  Spotify
//
//  Created by Elnur Mammadov on 19.04.25.
//

import Foundation

final class ArtistViewModel {
    private(set) var artist: ArtistInfo?
    private(set)var artistTopTracks = [TopTrack]()
    private(set) var actorID: String
    private var useCase: ArtistUseCase
    
    init(actorID: String, useCase: ArtistUseCase) {
        self.actorID = actorID
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
    
    func getArtistInfo() {
        self.state = .loading
        useCase.getArtistInfo(id: actorID) { data, error in
            if let data {
                self.artist = data
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
    
    func getArtistToptracks() {
        self.state = .loading
        useCase.getArtistTopTracks(id: actorID) { data, error in
            if let data {
                guard let items = data.tracks else { return }
                self.artistTopTracks = items
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
}
