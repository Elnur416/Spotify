//
//  SearchController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import UIKit

class SearchController: BaseController {
    
//    MARK: UI elements
    
    private lazy var searchController: UISearchController = {
        let vc = UISearchController(searchResultsController: SearchResultsController())
        vc.searchBar.placeholder = "Songs, Artists, Albums, Playlists"
        vc.searchBar.searchBarStyle = .minimal
        vc.definesPresentationContext = true
        return vc
    }()
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumLineSpacing = 16
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.showsVerticalScrollIndicator = false
        c.dataSource = self
        c.delegate = self
        c.register(CategoryCell.self, forCellWithReuseIdentifier: "\(CategoryCell.self)")
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    private lazy var indicatorview: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.style = .medium
        view.color = .gray
        return view
    }()
    
//    MARK: - Properties
    
    private let viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Task {
            await viewModel.getCategories()
        }
    }
    
    override func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Search"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        [indicatorview,
         collection].forEach { view.addSubview($0) }
        indicatorview.frame = view.bounds
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func configureViewModel() {
        viewModel.stateUpdated = { [weak self] state in
            switch state {
            case .success:
                self?.collection.reloadData()
            case .loading:
                self?.indicatorview.startAnimating()
            case .loaded:
                self?.indicatorview.stopAnimating()
            case .error(let error):
                self?.showAlert(message: error)
            case .idle:
                break
            }
        }
    }
}

extension SearchController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryCell.self)", for: indexPath) as! CategoryCell
        cell.configure(model: viewModel.categories[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width / 2 - 16, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let resultsController = searchController.searchResultsController as? SearchResultsController,
              let query = searchController.searchBar.text else { return }
        Task {
            await viewModel.getSearchResults(query: query)
        }
        guard let data = viewModel.searchResults else { return }
        resultsController.updateData(items: data)
        resultsController.artistIDCallback = { [weak self] id in
            let coordinator = ArtistCoordinator(navigationController: self?.navigationController ?? UINavigationController(),
                                                actorID: id)
            coordinator.start()
        }
    }
}
