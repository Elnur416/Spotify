//
//  ArtistViewModel.swift
//  Spotify
//
//  Created by Elnur Mammadov on 31.03.25.
//

import Foundation

final class FollowingArtistsViewModel {
    private(set) var artists = [ArtistInfo]()
    var useCase: UserUseCase
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    init(useCase: UserUseCase) {
        self.useCase = useCase
    }
    
    func getFollowingArtists() async {
        do {
            let data = try await useCase.getFollowedArtists()
            guard let items = data?.artists?.items else { return }
            self.artists = items
            await MainActor.run {
                success?()
            }
        } catch {
            await MainActor.run {
                self.error?(error.localizedDescription)
            }
        }
    }
}
