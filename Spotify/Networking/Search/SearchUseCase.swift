//
//  SearchUseCase.swift
//  Spotify
//
//  Created by Elnur Mammadov on 06.04.25.
//

import Foundation

protocol SearchUseCase {
    func search(query: String) async throws -> SearchResults?
    func getCategories() async throws -> Categories?
}
