//
//  SearchUseCase.swift
//  Spotify
//
//  Created by Elnur Mammadov on 06.04.25.
//

import Foundation

protocol SearchUseCase {
    func search(query: String, completion: @escaping ((SearchResults?, String?) -> Void))
    func getCategories(completion: @escaping ((Categories?, String?) -> Void))
}
