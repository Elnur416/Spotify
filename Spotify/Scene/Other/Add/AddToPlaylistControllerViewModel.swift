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
    
    func getUserPlaylists() async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await useCase.getUserPlaylists()
            guard let items = data?.items else { return }
            self.playlists = items
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
    
    func addTrackToPlaylist(withId playlistId: String) async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await useCase.addItemsToPlaylist(id: playlistId, uris: trackURI ?? "")
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
