//
//  HomeDataProtocol.swift
//  Spotify
//
//  Created by Elnur Mammadov on 01.04.25.
//

import Foundation

protocol ImageLabelCellProtocol {
    var nameText: String { get }
    var imageURL: String { get }
    var itemId: String { get }
    var artistName: String { get }
    var trackPreviewURL: String { get }
}
