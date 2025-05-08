//
//  ArtistController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 31.03.25.
//

import UIKit

class FollowingArtistsController: BaseController {
    
    let viewModel: FollowingArtistsViewModel
    
    init(viewModel: FollowingArtistsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: UI elements
    
    private lazy var table: UITableView = {
        let t = UITableView()
        t.backgroundColor = .clear
        t.dataSource = self
        t.delegate = self
        t.register(ArtistCell.self, forCellReuseIdentifier: "\(ArtistCell.self)")
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()
        
//    MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.getFollowingArtists()
    }
    
    @objc private func refreshData() {
        viewModel.getFollowingArtists()
    }
    
    override func setupUI() {
        title = "Following"
        view.backgroundColor = .black
        view.addSubview(table)
        table.refreshControl = refreshControl
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func configureViewModel() {
        viewModel.success = { [weak self] in
            self?.table.reloadData()
            self?.refreshControl.endRefreshing()
        }
        viewModel.error = { [weak self] error in
            self?.showAlert(message: error)
        }
    }
}

extension FollowingArtistsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ArtistCell.self)", for: indexPath) as! ArtistCell
        cell.configure(model: viewModel.artists[indexPath.item], type: .profile)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        .init(66)
    }
}
