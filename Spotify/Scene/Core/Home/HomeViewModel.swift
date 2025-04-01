//
//  HomeViewModel.swift
//  Spotify
//
//  Created by Elnur Mammadov on 31.03.25.
//

import Foundation

enum DataTitle: String {
    case newRelease = "New Release"
    case tracks = "Made For You"
    case artists = "Your Top Artists"
}

struct DataType {
    let title: DataTitle
    let items: [HomeDataProtocol]
}

final class HomeViewModel {
    private(set) var user: UserProfile?
    private(set) var data = [DataType]()
    private let userUseCase: UserUseCase
    private let homeUseCase: HomeUseCase
    
    init(userUseCase: UserUseCase, homeUseCase: HomeUseCase) {
        self.userUseCase = userUseCase
        self.homeUseCase = homeUseCase
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
        getCurrentUser()
        getNewReleases()
        getTopArtists()
        getTopTracks()
    }
    
    private func getCurrentUser() {
        state = .loading
        userUseCase.getCurrentUserProfile { data, error in
            if let data {
                self.user = data
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
    
    private func getNewReleases() {
        state = .loading
        homeUseCase.getNewRelease { data, error in
            if let data {
                guard let items = data.albums?.items else { return }
                let item: [DataType] = [.init(title: .newRelease, items: items)]
                self.data.append(contentsOf: item)
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
    
    private func getTopArtists() {
        self.state = .loading
        homeUseCase.getTopArtists { data, error in
            if let data {
                guard let items = data.items else { return }
                let item: [DataType] = [.init(title: .artists, items: items)]
                self.data.append(contentsOf: item)
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
    
    private func getTopTracks() {
        self.state = .loading
        homeUseCase.getTopTracks { data, error in
            if let data {
                guard let items = data.items else { return }
                let item: [DataType] = [.init(title: .tracks, items: items)]
                self.data.append(contentsOf: item)
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
}
