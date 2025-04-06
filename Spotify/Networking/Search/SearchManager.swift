//
//  SearchManager.swift
//  Spotify
//
//  Created by Elnur Mammadov on 06.04.25.
//

import Foundation

final class SearchManager: SearchUseCase {
    private let manager = NetworkManager()
    
    func search(query: String, completion: @escaping ((SearchResults?, String?) -> Void)) {
        let path = SearchEndpoint.search(text: query).path
        manager.request(path: path,
                        model: SearchResults.self,
                        completion: completion)
    }
    
    func getCategories(completion: @escaping ((Categories?, String?) -> Void)) {
        let path = SearchEndpoint.category.path
        manager.request(path: path,
                        model: Categories.self,
                        completion: completion)
    }
}
