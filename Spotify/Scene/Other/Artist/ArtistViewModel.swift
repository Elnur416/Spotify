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
    private(set) var isArtistFollowing: [Bool]?
    private var useCase: ArtistUseCase
    private var trackUseCase: TrackUseCase
    var selectedTrack: TopTrack?
    
    init(actorID: String, useCase: ArtistUseCase, trackUseCase: TrackUseCase) {
        self.actorID = actorID
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
    
    func getAllData() {
        getArtistInfo()
        getArtistToptracks()
        checkFollowStatus()
    }
    
    private func getArtistInfo() {
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
    
    private func getArtistToptracks() {
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
    
    private func checkFollowStatus() {
        self.state = .loading
        useCase.checkFollowStatus(id: actorID) { data, error in
            if let data {
                self.isArtistFollowing = data
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
    
    func followArtist() {
        self.state = .loading
        useCase.followArtist(id: actorID) { data, error in
            if data != nil {
                self.isArtistFollowing = [true]
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
    
    func unfollowArtist() {
        self.state = .loading
        useCase.unfollowArtist(id: actorID) { data, error in
            if data != nil {
                self.isArtistFollowing = [false]
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
