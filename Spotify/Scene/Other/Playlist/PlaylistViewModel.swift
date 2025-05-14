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
    var tracks = [Item]()
    
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
                print(data.primaryColor ?? "")
                self.playlist = data
                self.tracks = data.tracks?.items ?? []
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
    
    func saveChanges(name: String) {
        self.state = .loading
        useCase.editPlaylistName(id: playlistID,
                                 name: name) { data, error in
            if data == nil {
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
    
    func removeTrackFromPlaylist(at index: Int) {
        useCase.removeItemsFromPlaylist(id: playlistID,
                                        uris: tracks[index].track?.uri ?? "",
                                        snapshotId: playlist?.snapshotID ?? "") { data, error in
            if let data {
                print(data)
            } else if let error {
                self.state = .error(error)
            }
        }
    }
}
