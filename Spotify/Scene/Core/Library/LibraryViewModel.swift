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
    
    func getAllData() async {
        await getUserPLaylists()
        await getUserSavedAlbums()
        await getUserSavedTracks()
    }
    
    private func getUserPLaylists() async {
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
    
    private func getUserSavedAlbums() async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await useCase.getUserSavedAlbums()
            guard let items = data?.items else { return }
            self.albums = items
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
    
    private func getUserSavedTracks() async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await useCase.getUserSavedTracks()
            self.tracks = data?.items ?? []
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
    
    func createPlaylist(name: String) async {
        guard let userID = UserDefaults.standard.string(forKey: "userID") else { return }
        await MainActor.run {
            state = .loading
        }
        do {
            guard let data = try await useCase.createPlaylist(name: name, userId: userID) else { return }
            self.playlists.insert(data, at: 0)
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
    
    func deleteAlbumFromLibrary(id: String) async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await useCase.deleteAlbum(id: id)
            if data == nil {
                self.albums.removeAll { $0.itemId == id }
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
    
    func deleteTrackFromLibrary(id: String) async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await useCase.deleteTrack(id: id)
            if data == nil {
                self.tracks.removeAll { $0.track?.id ?? "" == id }
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
