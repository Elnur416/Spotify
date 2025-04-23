//
//  ViewController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import UIKit

class HomeController: BaseController {
    
    //    MARK: UI elements
    
    private lazy var userImage: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .gray
        i.layer.cornerRadius = 16
        i.clipsToBounds = true
        i.layer.borderWidth = 1
        i.layer.borderColor = UIColor.white.cgColor
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let view = UISegmentedControl(items: self.items)
        view.selectedSegmentIndex = 0
        view.selectedSegmentTintColor = UIColor(named: "green2")
        view.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        view.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        view.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 1
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.backgroundColor = .clear
        c.dataSource = self
        c.delegate = self
        c.showsVerticalScrollIndicator = false
        c.register(HomeSectionCell.self, forCellWithReuseIdentifier: "\(HomeSectionCell.self)")
        c.register(HomeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(HomeHeaderView.self)")
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
    
    private let viewModel: HomeViewModel
    private let items: [String] = ["All", "Albums", "Tracks"]
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getAllData()
    }
    
    override func setupUI() {
        navigationController?.navigationBar.isHidden = true
        [indicatorview,
         userImage,
         segmentControl,
         collection].forEach { view.addSubview($0) }
        indicatorview.frame = view.bounds
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            userImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            userImage.widthAnchor.constraint(equalToConstant: 32),
            userImage.heightAnchor.constraint(equalToConstant: 32),
            
            segmentControl.topAnchor.constraint(equalTo: userImage.topAnchor),
            segmentControl.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 12),
            segmentControl.heightAnchor.constraint(equalToConstant: 32),
            
            collection.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 20),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func configureViewModel() {
        viewModel.stateUpdated = { [weak self] state in
            switch state {
            case .loading:
                self?.indicatorview.startAnimating()
            case .loaded:
                self?.indicatorview.stopAnimating()
            case .success:
                self?.configureUserInfo()
                self?.collection.reloadData()
            case .error(let error):
                self?.showAlert(message: error)
            case .idle:
                break
            }
        }
    }
    
    private func configureUserInfo() {
        self.load(image: userImage, url: viewModel.user?.images?.first?.url ?? "")
    }
    
    @objc private func segmentChanged() {
        
    }
}

//MARK: - Configure CollectionView

extension HomeController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HomeSectionCell.self)", for: indexPath) as!
        HomeSectionCell
        cell.configure(text: viewModel.data[indexPath.item].title?.rawValue ?? "",
                       data: viewModel.data[indexPath.item])
        cell.indexCallBack = { [weak self] type, id in
            if type == .album {
                let coordinator = AlbumCoordinator(navigationController: self?.navigationController ?? UINavigationController(),
                                                   id: id)
                coordinator.start()
            } else if type == .artist {
                let coordinator = ArtistCoordinator(navigationController: self?.navigationController ?? UINavigationController(),
                                                    actorID: id)
                coordinator.start()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: "\(HomeHeaderView.self)",
                                                                     for: indexPath) as! HomeHeaderView
        header.configure(data: viewModel.recentlyPlayed)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: collectionView.frame.width, height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: 250)
    }
}
