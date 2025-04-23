//
//  LibraryController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import UIKit

class LibraryController: BaseController {
    
    private let viewModel: LibraryViewModel
    
    init(viewMOdel: LibraryViewModel) {
        self.viewModel = viewMOdel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: UI elements
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 60
        layout.sectionInset = .init(top: 16, left: 30, bottom: 60, right: 30)
        layout.scrollDirection = .vertical
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.dataSource = self
        c.delegate = self
        c.showsVerticalScrollIndicator = false
        c.register(ImageLabelCell.self,
                   forCellWithReuseIdentifier: "\(ImageLabelCell.self)")
        c.register(LibraryHeaderView.self,
                   forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                   withReuseIdentifier: "\(LibraryHeaderView.self)")
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    private lazy var indicatorview: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.style = .medium
        view.color = .gray
        return view
    }()
    
//    MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getAllData()
    }
    
    override func setupUI() {
        view.backgroundColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Library"
        [indicatorview,
         collection].forEach { view.addSubview($0) }
        indicatorview.frame = view.bounds
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func configureViewModel() {
        viewModel.stateUpdated = { state in
            switch state {
            case .loading:
                self.indicatorview.startAnimating()
            case .loaded:
                self.indicatorview.stopAnimating()
            case .success:
                self.collection.reloadData()
            case .error(let error):
                self.showAlert(message: error)
            case .idle:
                break
            }
        }
    }
}

extension LibraryController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.section == .playlists {
            return viewModel.playlists.count
        } else {
            return viewModel.albums.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ImageLabelCell.self)", for: indexPath) as! ImageLabelCell
        if viewModel.section == .playlists {
            cell.configure(model: viewModel.playlists[indexPath.item],
                           type: .album)
        } else {
            cell.configure(model: viewModel.albums[indexPath.item],
                           type: .album)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: "\(LibraryHeaderView.self)",
                                                                     for: indexPath) as! LibraryHeaderView
        header.sectionCallBack = { [weak self] title in
            self?.viewModel.section = title
            self?.collection.reloadData()
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: collectionView.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.section == .playlists {
            let coordinator = PlaylistCoordinator(navigationController: navigationController ?? UINavigationController(),
                                                  id: viewModel.playlists[indexPath.item].id ?? "")
            coordinator.start()
        } else {
            let coordinator = AlbumCoordinator(navigationController: self.navigationController ?? UINavigationController(),
                                               id: viewModel.albums[indexPath.item].album?.id ?? "")
            coordinator.start()
        }
    }
}
