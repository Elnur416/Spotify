//
//  UserManager.swift
//  Spotify
//
//  Created by Elnur Mammadov on 29.03.25.
//

import Foundation
import Alamofire

final class UserManager: UserUseCase {
    private let manager = NetworkManager()
    
    func getCurrentUserProfile() async throws -> UserProfile? {
        let path = UserEndpoint.currentUser.path
        return try await manager.request(path: path,
                                         model: UserProfile.self)
    }
    
    func getUserPlaylists() async throws -> Playlists? {
        let path = UserEndpoint.userPlaylists.path
        return try await manager.request(path: path,
                                         model: Playlists.self)
    }
    
    func getFollowedArtists() async throws -> Artists? {
        let path = UserEndpoint.followedArtists.path
        return try await manager.request(path: path,
                                         model: Artists.self)
    }
}
