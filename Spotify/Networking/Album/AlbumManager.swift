//
//  AlbumManager.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import Foundation

final class AlbumManager: AlbumUseCase {
    private let manager = NetworkManager()
    
    func getAlbum(id: String, completion: @escaping (Album6?, String?) -> Void) {
        let path = AlbumEndpoint.album(id: id).path
        manager.request(path: path,
                        model: Album6.self,
                        completion: completion)
    }
    
    func saveAlbum(id: String, completion: @escaping (Empty?, String?) -> Void) {
        let path = AlbumEndpoint.saveAlbum.path
        let params: [String: Any] = ["ids": [
            "\(id)"
        ]]
        manager.request(path: path,
                        model: Empty.self,
                        method: .put,
                        params: params,
                        encodingType: .json,
                        completion: completion)
    }
}
