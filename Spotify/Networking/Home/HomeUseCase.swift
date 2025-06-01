//
//  HomeUseCase.swift
//  Spotify
//
//  Created by Elnur Mammadov on 01.04.25.
//

import Foundation

protocol HomeUseCase {
    func getNewRelease() async throws -> Albums?
    func getTopArtists() async throws -> ArtistsClass?
    func getTopTracks() async throws -> Tracks?
    func getRecentlyTracks() async throws -> RecentlyTracks?
}
