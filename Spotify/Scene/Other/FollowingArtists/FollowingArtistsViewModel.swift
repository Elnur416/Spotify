//
//  ArtistViewModel.swift
//  Spotify
//
//  Created by Elnur Mammadov on 31.03.25.
//

import Foundation

final class FollowingArtistsViewModel {
    var artists: [ArtistInfo]
    
    init(artists: [ArtistInfo]) {
        self.artists = artists
    }
}
