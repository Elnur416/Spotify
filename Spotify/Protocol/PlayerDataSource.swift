//
//  PlayerDataSource.swift
//  Spotify
//
//  Created by Elnur Mammadov on 03.05.25.
//

import Foundation

protocol PlayerDataSource: AnyObject {
    var songName: String { get }
    var subtitle: String { get }
    var imageURL: String { get }
}
