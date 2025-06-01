//
//  ArtistUseCase.swift
//  Spotify
//
//  Created by Elnur Mammadov on 23.04.25.
//

import Foundation

protocol ArtistUseCase {
    func getArtistInfo(id: String) async throws -> ArtistInfo?
    func getArtistTopTracks(id: String) async throws -> ArtistTopTracks?
    func checkFollowStatus(id: String) async throws -> [Bool]?
    func followArtist(id: String) async throws -> Empty?
    func unfollowArtist(id: String) async throws -> Empty?
}
