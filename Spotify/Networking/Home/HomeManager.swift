//
//  HomeManager.swift
//  Spotify
//
//  Created by Elnur Mammadov on 01.04.25.
//

import Foundation

final class HomeManager: HomeUseCase {
    private let manager = NetworkManager()
    
    func getNewRelease(completion: @escaping ((Albums?, String?) -> Void)) {
        let path = HomeEndpoint.newReleases.path
        manager.request(path: path,
                        model: Albums.self,
                        completion: completion)
    }
    
    func getTopArtists(completion: @escaping ((ArtistsClass?, String?) -> Void)) {
        let path = HomeEndpoint.artists.path
        manager.request(path: path,
                        model: ArtistsClass.self,
                        completion: completion)
    }
    
    func getTopTracks(completion: @escaping ((Tracks?, String?) -> Void)) {
        let path = HomeEndpoint.tracks.path
        manager.request(path: path,
                        model: Tracks.self,
                        completion: completion)
    }
    
    func getRecentlyTracks(completion: @escaping ((RecentlyTracks?, String?) -> Void)) {
        let path = HomeEndpoint.recentlyTracks.path
        manager.request(path: path,
                        model: RecentlyTracks.self,
                        completion: completion)
    }
}
