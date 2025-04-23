//
//  ArtistUseCase.swift
//  Spotify
//
//  Created by Elnur Mammadov on 23.04.25.
//

import Foundation

protocol ArtistUseCase {
    func getArtistInfo(id: String, completion: @escaping ((ArtistInfo?, String?) -> Void))
}
