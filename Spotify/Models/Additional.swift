//
//  Additional.swift
//  Spotify
//
//  Created by Elnur Mammadov on 09.05.25.
//

import Foundation

struct SnapshotResponse: Codable {
    let snapshotID: String?
    
    enum CodingKeys: String, CodingKey {
        case snapshotID = "snapshot_id"
    }
}
