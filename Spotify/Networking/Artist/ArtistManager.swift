//
//  ArtistManager.swift
//  Spotify
//
//  Created by Elnur Mammadov on 23.04.25.
//

import Foundation

final class ArtistManager: ArtistUseCase {
    private let manager = NetworkManager()
    
    func getArtistInfo(id: String) async throws -> ArtistInfo? {
        let path = ArtistEndpoint.artist(id: id).path
        return try await manager.request(path: path,
                        model: ArtistInfo.self)
    }
    
    func getArtistTopTracks(id: String) async throws -> ArtistTopTracks? {
        let path = ArtistEndpoint.topTracks(id: id).path
        return try await manager.request(path: path,
                        model: ArtistTopTracks.self)
    }
    
    func checkFollowStatus(id: String) async throws -> [Bool]? {
        let path = ArtistEndpoint.checkFollow(id: id).path
        return try await manager.request(path: path,
                        model: [Bool].self)
    }
    
    func followArtist(id: String) async throws -> Empty? {
        let path = ArtistEndpoint.followOrUnfollowArtist.path
        let params: [String: Any] = ["ids": [
            "\(id)"
        ]]
        return try await manager.request(path: path,
                        model: Empty.self,
                        method: .put,
                        params: params,
                        encodingType: .json)
    }
    
    func unfollowArtist(id: String) async throws -> Empty? {
        let path = ArtistEndpoint.followOrUnfollowArtist.path
        let params: [String: Any] = ["ids": [
            "\(id)"
        ]]
        return try await manager.request(path: path,
                        model: Empty.self,
                        method: .delete,
                        params: params,
                        encodingType: .json)
    }
}

