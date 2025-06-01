//
//  UserUseCase.swift
//  Spotify
//
//  Created by Elnur Mammadov on 29.03.25.
//

import Foundation

protocol UserUseCase {
    func getCurrentUserProfile() async throws -> UserProfile?
    func getUserPlaylists() async throws -> Playlists?
    func getFollowedArtists() async throws -> Artists?
}
