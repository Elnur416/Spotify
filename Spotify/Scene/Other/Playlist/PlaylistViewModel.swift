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
    
    func getPlaylist() async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await useCase.getPlaylist(id: playlistID)
            self.playlist = data
            self.tracks = data?.tracks?.items ?? []
            await MainActor.run {
                state = .loaded
                state = .success
            }
        } catch {
            await MainActor.run {
                state = .error(error.localizedDescription)
            }
        }
    }
    
    func saveChanges(name: String) async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await useCase.editPlaylistName(id: playlistID, name: name)
            if data == nil {
                await MainActor.run {
                    state = .loaded
                    state = .success
                }
            }
        } catch {
            await MainActor.run {
                state = .error(error.localizedDescription)
            }
        }
    }
    
    func removeTrackFromPlaylist(uri: String, snapshotID: String) async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await  useCase.removeItemsFromPlaylist(id: playlistID,
                                                                  uris: uri,
                                                                  snapshotId: snapshotID)
            await MainActor.run {
                state = .loaded
                state = .success
            }
        } catch {
            await MainActor.run {
                state = .error(error.localizedDescription)
            }
        }
    }
}
