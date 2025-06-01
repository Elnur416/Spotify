//
//  AlbumManager.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import Foundation

final class AlbumManager: AlbumUseCase {
    private let manager = NetworkManager()
    
    func getAlbum(id: String) async throws -> Album6? {
        let path = AlbumEndpoint.album(id: id).path
        return try await manager.request(path: path,
                                         model: Album6.self)
    }
    
    func saveAlbum(id: String) async throws -> Empty? {
        let path = AlbumEndpoint.saveAlbum.path
        let params: [String: Any] = ["ids": [
            "\(id)"
        ]]
        return try await manager.request(path: path,
                        model: Empty.self,
                        method: .put,
                        params: params,
                        encodingType: .json)
    }
}
