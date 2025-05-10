//
//  ArtistController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 19.04.25.
//

import UIKit

class ArtistController: BaseController {
    
//    MARK: UI elements
    
    private lazy var table: UITableView = {
       let t = UITableView()
        t.showsVerticalScrollIndicator = false
        t.backgroundColor = .clear
        t.register(TrackInAlbumCell.self, forCellReuseIdentifier: "\(TrackInAlbumCell.self)")
        t.dataSource = self
        t.delegate = self
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private lazy var backButton: UIButton = {
        let b = UIButton(type: .custom)
        b.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        b.tintColor = .white
        b.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        b.backgroundColor = .clear
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private lazy var indicatorview: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.style = .medium
        view.color = .gray
        return view
    }()
    
//    MARK: - Properties
    
    private let viewModel: ArtistViewModel
    
    init(viewModel: ArtistViewModel) {
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
        configureTableHeader()
    }
    
    override func setupUI() {
        setupGradientLayer()
        navigationController?.navigationBar.isHidden = true
        [indicatorview,
         table,
         backButton].forEach { view.addSubview($0) }
        indicatorview.frame = view.bounds
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.topAnchor, constant: -62),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24)
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
                self?.configureData()
                self?.table.reloadData()
            case .error(let error):
                self?.showAlert(message: error)
            case .idle:
                break
            }
        }
    }
    
    private func configureData() {
        guard let data = viewModel.artist,
        let header = table.tableHeaderView as? ArtistTableHeaderView else { return }
        header.configure(model: data, isFollowing: viewModel.isArtistFollowing?.first ?? false)
        header.followCallback = { [weak self] in
            self?.viewModel.followArtist()
        }
        header.unfollowCallback = { [weak self] in
            self?.viewModel.unfollowArtist()
        }
    }
    
    private func configureTableHeader() {
        let header = ArtistTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 370))
        table.tableHeaderView = header
    }
    
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
        navigationController?.navigationBar.isHidden = false
    }
}

extension ArtistController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.artistTopTracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(TrackInAlbumCell.self)") as! TrackInAlbumCell
        cell.configure(model: viewModel.artistTopTracks[indexPath.item])
        cell.addCallBack = { [weak self] in
            self?.viewModel.selectedTrack = self?.viewModel.artistTopTracks[indexPath.item]
            let controller = AddController()
            controller.delegate = self
            let navController = UINavigationController(rootViewController: controller)
            if let sheet = navController.sheetPresentationController {
                sheet.detents = [
                    .custom { _ in return 200 }
                ]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 20
            }
            self?.present(navController, animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        .init(66)
    }
}

extension ArtistController: AddControllerDelegate {
    func addToPlaylist() {
        let coordinator = AddToPlaylistCoordinator(navigationController: self.navigationController ?? UINavigationController(),
                                                   trackURI: viewModel.selectedTrack?.uri ?? "")
        coordinator.start()
    }
    
    func saveTrack() {
        let id = viewModel.selectedTrack?.id ?? ""
        viewModel.saveTrackToLibrary(trackID: id)
    }
}
