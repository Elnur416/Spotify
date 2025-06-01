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
    
    func getAlbum() async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await useCase.getAlbum(id: id)
            self.album = data
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
    
    func saveAlbum() async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await useCase.saveAlbum(id: id)
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
    
    func saveTrackToLibrary(trackID: String) async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await trackUseCase.saveTrack(id: id)
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
