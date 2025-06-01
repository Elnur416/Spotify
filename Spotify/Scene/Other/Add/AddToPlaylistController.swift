//
//  AddToPlaylistController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 09.05.25.
//

import UIKit

class AddToPlaylistController: BaseController {
    
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
    
    private lazy var cancelButton: UIButton = {
        let b = UIButton(type: .custom)
        b.setTitle( "Cancel", for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 16
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor.lightGray.cgColor
        b.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
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
    
    private let viewModel: AddToPlaylistControllerViewModel
    
    init(viewModel: AddToPlaylistControllerViewModel) {
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
            await viewModel.getUserPlaylists()
        }
    }
    
    override func setupUI() {
        view.backgroundColor = .black
        [indicatorview,
         table,
         cancelButton].forEach { view.addSubview($0) }
        indicatorview.frame = view.bounds
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 40),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            cancelButton.heightAnchor.constraint(equalToConstant: 32),
            cancelButton.widthAnchor.constraint(equalToConstant: 100)
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
                self?.table.reloadData()
            case .error(let error):
                self?.showAlert(message: error)
            case .idle:
                break
            }
        }
    }
    
    @objc private func cancelAction() {
        dismiss(animated: true)
    }
}

extension AddToPlaylistController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PlaylistCell.self)", for: indexPath) as! PlaylistCell
        cell.configure(model: viewModel.playlists[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Task {
            await viewModel.addTrackToPlaylist(withId: viewModel.playlists[indexPath.item].id ?? "")
        }
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
}
