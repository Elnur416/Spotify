//
//  ProfileViewModel.swift
//  Spotify
//
//  Created by Elnur Mammadov on 25.03.25.
//

import Foundation

final class ProfileViewModel {
    private(set) var user: UserProfile?
    private(set) var artists = [ArtistInfo]()
    private(set) var playlists = [PlaylistItem]()
    private let useCase: UserUseCase
    
    init(useCase: UserUseCase) {
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
    
    func getAllData() async {
        await getCurrentUser()
        await getUserPlaylists()
        await getFollowedArtists()
    }
    
    private func getCurrentUser() async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await useCase.getCurrentUserProfile()
            self.user = data
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
    
    private func getFollowedArtists() async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await useCase.getFollowedArtists()
            guard let items = data?.artists?.items else { return }
            self.artists = items
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
    
    private func getUserPlaylists() async {
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
}
