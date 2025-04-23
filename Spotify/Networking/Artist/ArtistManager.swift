//
//  ArtistManager.swift
//  Spotify
//
//  Created by Elnur Mammadov on 23.04.25.
//

import Foundation

final class ArtistManager: ArtistUseCase {
    private let manager = NetworkManager()
    
    func getArtistInfo(id: String, completion: @escaping (ArtistInfo?, String?) -> Void) {
        let path = ArtistEndpoint.artist(id: id).path
        manager.request(path: path,
                        model: ArtistInfo.self,
                        completion: completion)
    }
}

