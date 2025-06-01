//
//  AlbumUseCase.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import Foundation

protocol AlbumUseCase {
    func getAlbum(id: String) async throws -> Album6?
    func saveAlbum(id: String) async throws -> Empty?
}
