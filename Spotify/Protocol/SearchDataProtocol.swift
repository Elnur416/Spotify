//
//  SearchDataProtocol.swift
//  Spotify
//
//  Created by Elnur Mammadov on 16.04.25.
//

import Foundation

protocol SearchDataProtocol {
    var titleName: String { get }
    var imageURL: String { get }
    var followersCount: Int { get }
}
