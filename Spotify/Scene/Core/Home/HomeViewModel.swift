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

enum HomeDataType {
    case artist
    case track
    case album
}

struct DataType {
    let title: DataTitle?
    let items: [ImageLabelCellProtocol]?
    let type: HomeDataType?
}

final class HomeViewModel {
    private(set) var user: UserProfile?
    private(set) var data = [DataType]()
    private(set) var recentlyPlayed = [RecentItem]()
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
    
    func getAllData() async {
        await getCurrentUser()
        await getRecentlyPlayed()
        await getTopArtists()
        await getTopTracks()
        await getNewReleases()
    }
    
    private func getCurrentUser() async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await userUseCase.getCurrentUserProfile()
            user = data
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
    
    private func getNewReleases() async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await homeUseCase.getNewRelease()
            guard let items = data?.albums?.items else { return }
            let item: [DataType] = [.init(title: .newRelease,
                                          items: items,
                                          type: .album)]
            self.data.append(contentsOf: item)
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
    
    private func getTopArtists() async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await homeUseCase.getTopArtists()
            guard let items = data?.items else { return }
            let item: [DataType] = [.init(title: .artists,
                                          items: items,
                                          type: .artist)]
            self.data.append(contentsOf: item)
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
    
    private func getTopTracks() async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await homeUseCase.getTopTracks()
            guard let items = data?.items else { return }
            let item: [DataType] = [.init(title: .tracks,
                                          items: items,
                                          type: .track)]
            self.data.append(contentsOf: item)
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
    
    private func getRecentlyPlayed() async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await homeUseCase.getRecentlyTracks()
            guard let items = data?.items else { return }
            self.recentlyPlayed = items
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
