//
//  PlaylistsListController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 31.03.25.
//

import UIKit

class PlaylistsListController: BaseController {
    
    private let viewModel: PlaylistsListViewModel
    
    init(viewModel: PlaylistsListViewModel) {
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
        t.register(PlaylistCell.self, forCellReuseIdentifier: "\(PlaylistCell.self)")
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
//    MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func setupUI() {
        title = "Playlists"
        view.backgroundColor = .black
        view.addSubview(table)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

//MARK: - Configure TableView

extension PlaylistsListController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.playLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PlaylistCell.self)", for: indexPath) as! PlaylistCell
        cell.configure(model: viewModel.playLists[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coordinator = PlaylistCoordinator(navigationController: self.navigationController ?? UINavigationController(),
                                              id: viewModel.playLists[indexPath.item].id ?? "")
        coordinator.start()
    }
}
