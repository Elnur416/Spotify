//
//  ProfileViewModel.swift
//  Spotify
//
//  Created by Elnur Mammadov on 25.03.25.
//

import Foundation

final class ProfileViewModel {
    private(set) var user: UserProfile?
    private(set) var playlists: Playlists?
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
    
    func getCurrentUser() {
        state = .loading
        useCase.getCurrentUserProfile { data, error in
            if let data {
                self.user = data
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
    
    func getUserPlaylists() {
        state = .loading
        useCase.getUserPlaylists { data, error in
            if let data {
                self.playlists = data
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
}
