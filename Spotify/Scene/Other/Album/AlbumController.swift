//
//  AlbumController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import UIKit

class AlbumController: BaseController {

//    MARK: UI elements
    
    private lazy var backButton: UIButton = {
        let b = UIButton(type: .custom)
        b.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        b.tintColor = .white
        b.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        b.backgroundColor = .clear
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
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
    
    private lazy var indicatorview: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.style = .medium
        view.color = .gray
        return view
    }()
    
//    MARK: - Properties
    
    private let viewModel: AlbumViewModel
    
    init(viewModel: AlbumViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await viewModel.getAlbum()
        }
        configureHeaderView()
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
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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
    
    private func configureHeaderView() {
        let header = TableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 370))
        table.tableHeaderView = header
        header.saveActionHandler = { [weak self] in
            Task {
                await self?.viewModel.saveAlbum()
            }
        }
    }
    
    private func configureData() {
        guard let data = viewModel.album,
        let header = table.tableHeaderView as? TableHeaderView else { return }
        header.configure(model: data, type: .album)
    }
    
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
        navigationController?.navigationBar.isHidden = false
    }
}

extension AlbumController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.album?.tracks?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(TrackInAlbumCell.self)") as! TrackInAlbumCell
        guard let data = viewModel.album?.tracks?.items?[indexPath.item] else { return cell }
        cell.configure(model: data)
        cell.addCallBack = { [weak self] in
            self?.viewModel.selectedTrack = self?.viewModel.album?.tracks?.items?[indexPath.item]
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
        66
    }
}

extension AlbumController: AddControllerDelegate {
    func addToPlaylist() {
        let coordinator = AddToPlaylistCoordinator(navigationController: self.navigationController ?? UINavigationController(),
                                                   trackURI: viewModel.selectedTrack?.uri ?? "")
        coordinator.start()
    }
    
    func saveTrack() {
        Task {
            await viewModel.saveTrackToLibrary(trackID: viewModel.selectedTrack?.id ?? "")
        }
    }
}

