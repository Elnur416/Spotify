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
    
    func getFollowingArtists() {
        useCase.getFollowedArtists { data, error in
            if let data {
                guard let items = data.artists?.items else { return }
                self.artists = items
                self.success?()
            } else if let error {
                self.error?(error)
            }
        }
    }
}
