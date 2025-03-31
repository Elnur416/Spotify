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
    
    func getCurrentUserProfile(completion: @escaping ((UserProfile?, String?) -> Void)) {
        let path = UserEndpoint.currentUser.path
        manager.request(path: path,
                        model: UserProfile.self,
                        completion: completion)
    }
    
    func getUserPlaylists(completion: @escaping ((Playlists?, String?) -> Void)) {
        let path = UserEndpoint.userPlaylists.path
        manager.request(path: path,
                        model: Playlists.self,
                        completion: completion)
    }
    
    func getFollowedArtists(completion: @escaping ((Artists?, String?) -> Void)) {
        let path = UserEndpoint.followedArtists.path
        manager.request(path: path,
                        model: Artists.self,
                        completion: completion)
    }
}
