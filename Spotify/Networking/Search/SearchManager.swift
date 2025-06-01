//
//  SearchManager.swift
//  Spotify
//
//  Created by Elnur Mammadov on 06.04.25.
//

import Foundation

final class SearchManager: SearchUseCase {
    private let manager = NetworkManager()
    
    func search(query: String) async throws -> SearchResults? {
        let path = SearchEndpoint.search(text: query).path
        return try await manager.request(path: path,
                                         model: SearchResults.self)
    }
    
    func getCategories() async throws -> Categories? {
        let path = SearchEndpoint.category.path
        return try await manager.request(path: path,
                                         model: Categories.self)
    }
    
}
