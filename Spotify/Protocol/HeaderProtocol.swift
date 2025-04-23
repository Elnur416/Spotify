//
//  HeaderProtocol.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import Foundation

protocol HeaderProtocol {
    var mainImage: String { get }
    var titleName: String { get }
    var ownerName: String { get }
    var totalTracksCount: Int { get }
}
