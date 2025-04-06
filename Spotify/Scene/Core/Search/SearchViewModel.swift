//
//  SearchViewModel.swift
//  Spotify
//
//  Created by Elnur Mammadov on 06.04.25.
//

import Foundation

final class SearchViewModel {
    private var useCase: SearchUseCase
    private(set) var categories = [CategoryItem]()
    
    init(useCase: SearchUseCase) {
        self.useCase = useCase
    }
    
    enum ViewState {
        case loading
        case loaded
        case success
        case error(String)
        case idle
    }
    
    var stateUpdated: ((ViewState) -> Void)?
    
    var state: ViewState = .idle {
        didSet {
            stateUpdated?(state)
        }
    }
    
    func getSearchResults(query: String) {
        self.state = .loading
        useCase.search(query: query) { data, error in
            if let data {
                print(data)
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
    
    func getCategories() {
        self.state = .loading
        useCase.getCategories { data, error in
            if let data {
                guard let items = data.categories?.items else { return }
                self.categories = items
                self.state = .loaded
                self.state = .success
            } else if let error {
                self.state = .error(error)
            }
        }
    }
}
