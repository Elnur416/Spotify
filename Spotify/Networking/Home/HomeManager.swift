//
//  HomeManager.swift
//  Spotify
//
//  Created by Elnur Mammadov on 01.04.25.
//

import Foundation

final class HomeManager: HomeUseCase {
    private let manager = NetworkManager()
    
    func getNewRelease() async throws -> Albums? {
        let path = HomeEndpoint.newReleases.path
        return try await manager.request(path: path,
                        model: Albums.self)
    }
    
    func getTopArtists() async throws -> ArtistsClass? {
        let path = HomeEndpoint.artists.path
        return try await manager.request(path: path,
                        model: ArtistsClass.self)
    }
    
    func getTopTracks() async throws -> Tracks? {
        let path = HomeEndpoint.tracks.path
        return try await manager.request(path: path,
                        model: Tracks.self)
    }
    
    func getRecentlyTracks() async throws -> RecentlyTracks? {
        let path = HomeEndpoint.recentlyTracks.path
        return try await manager.request(path: path,
                        model: RecentlyTracks.self)
    }
}
