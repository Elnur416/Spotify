//
//  AlbumUseCase.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import Foundation

protocol AlbumUseCase {
    func getAlbum(id: String, completion: @escaping ((Album6?, String?) -> Void))
}
