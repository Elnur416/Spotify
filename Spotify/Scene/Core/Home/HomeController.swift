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
        c.register(ImageLabelCell.self, forCellWithReuseIdentifier: "\(ImageLabelCell.self)")
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
        switch segmentControl.selectedSegmentIndex {
        case 0:
            collection.reloadData()
        case 1:
            let layout = UICollectionViewFlowLayout()
            collection.collectionViewLayout = layout
            layout.sectionInset = .init(top: 0, left: 20, bottom: 40, right: 20)
            collection.reloadData()
        case 2:
            let layout = UICollectionViewFlowLayout()
            collection.collectionViewLayout = layout
            layout.sectionInset = .init(top: 0, left: 20, bottom: 40, right: 20)
            collection.reloadData()
        default:
            break
        }
    }
}

//MARK: - Configure CollectionView

extension HomeController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return viewModel.data.count
        case 1:
            return viewModel.data.first(where: { $0.type == .album })?.items?.count ?? 0
        case 2:
            return viewModel.data.first(where: { $0.type == .track })?.items?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HomeSectionCell.self)", for: indexPath) as!
            HomeSectionCell
            cell1.configure(data: viewModel.data[indexPath.item])
            cell1.indexCallBack = { [weak self] type, id in
                if type == .album {
                    let coordinator = AlbumCoordinator(navigationController: self?.navigationController ?? UINavigationController(),
                                                       id: id)
                    coordinator.start()
                } else if type == .artist {
                    let coordinator = ArtistCoordinator(navigationController: self?.navigationController ?? UINavigationController(),
                                                        actorID: id)
                    coordinator.start()
                }
                else if type == .track {
                    let track = self?.viewModel.data.filter({$0.type == .track}).first?.items?.filter({$0.itemId == id}).first
                    PlaybackPresenter.shared.startPlayback(from: self ?? UIViewController(), track: track!)
                }
            }
            return cell1
        case 1:
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ImageLabelCell.self)", for: indexPath) as! ImageLabelCell
            guard let data = viewModel.data.first(where: { $0.type == .album })?.items?[indexPath.item] else { return cell2 }
            cell2.configure(model: data, type: .album)
            return cell2
        case 2:
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ImageLabelCell.self)", for: indexPath) as! ImageLabelCell
            guard let data = viewModel.data.first(where: { $0.type == .track })?.items?[indexPath.item] else { return cell2 }
            cell2.configure(model: data, type: .track)
            return cell2
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: "\(HomeHeaderView.self)",
                                                                     for: indexPath) as! HomeHeaderView
        header.configure(data: viewModel.recentlyPlayed)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch segmentControl.selectedSegmentIndex {
        case 0:
                .init(width: collectionView.frame.width, height: 280)
        case 1:
                .init(width: 0, height: 0)
        default:
                .init(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            .init(width: collectionView.frame.width, height: 250)
        case 1:
                .init(width: 150, height: 200)
        case 2:
                .init(width: 150, height: 200)
        default:
                .init(width: collectionView.frame.width, height: 250)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            break
        case 1:
            guard let item = viewModel.data.first(where: { $0.type == .album })?.items?[indexPath.item] else { return }
            let coordinator = AlbumCoordinator(navigationController: self.navigationController ?? UINavigationController(), id: item.itemId)
            coordinator.start()
        case 2:
            let track = self.viewModel.data.first(where: { $0.type == .track })?.items?[indexPath.item]
            PlaybackPresenter.shared.startPlayback(from: self, track: track!)
        default:
            break
        }
    }
}
