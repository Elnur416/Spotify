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
    private(set) var searchResults: SearchResults?
    
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
    
    func getSearchResults(query: String) async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await useCase.search(query: query)
            self.searchResults = data
            await MainActor.run {
                state = .loaded
                state = .success
            }
        } catch {
            await MainActor.run {
                state = .error(error.localizedDescription)
            }
        }
    }
    
    func getCategories() async {
        await MainActor.run {
            state = .loading
        }
        do {
            let data = try await useCase.getCategories()
            guard let items = data?.categories?.items else { return }
            self.categories = items
            await MainActor.run {
                state = .loaded
                state = .success
            }
        } catch {
            await MainActor.run {
                state = .error(error.localizedDescription)
            }
        }
    }
}
