//
//  TrackManager.swift
//  Spotify
//
//  Created by Elnur Mammadov on 09.05.25.
//

import Foundation

final class TrackManager: TrackUseCase {
    private let manager = NetworkManager()
    
    func saveTrack(id: String) async throws -> Empty? {
        let path = TrackEndpoint.saveTrack.path
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
