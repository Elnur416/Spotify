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
    
    func getAllData() async {
        await getArtistInfo()
        await getArtistToptracks()
        await checkFollowStatus()
    }
    
    private func getArtistInfo() async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await useCase.getArtistInfo(id: actorID)
            self.artist = data
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
    
    private func getArtistToptracks() async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await useCase.getArtistTopTracks(id: actorID)
            guard let items = data?.tracks else { return }
            self.artistTopTracks = items
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
    
    private func checkFollowStatus() async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await useCase.checkFollowStatus(id: actorID)
            self.isArtistFollowing = data
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
    
    func followArtist() async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await useCase.followArtist(id: actorID)
            if data == nil {
                self.isArtistFollowing = [true]
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
    
    func unfollowArtist() async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await useCase.unfollowArtist(id: actorID)
            if data == nil {
                self.isArtistFollowing = [false]
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
    
    func saveTrackToLibrary(trackID: String) async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await trackUseCase.saveTrack(id: trackID)
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
}
