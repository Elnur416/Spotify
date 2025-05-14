//
//  ProfileController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import UIKit

class ProfileController: BaseController {
    
//    MARK: UI elements
    
    private lazy var image: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .gray
        i.layer.cornerRadius = 50
        i.clipsToBounds = true
        i.layer.borderWidth = 1
        i.layer.borderColor = UIColor.white.cgColor
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var name: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = .systemFont(ofSize: 24, weight: .bold)
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var email: UILabel = {
        let l = UILabel()
        l.textColor = .lightGray
        l.font = .systemFont(ofSize: 12, weight: .regular)
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var followView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var followerNumber: UILabel = {
        let l = UILabel()
        l.text = "100"
        l.font = .systemFont(ofSize: 12, weight: .regular)
        l.textColor = .white
        l.numberOfLines = 0
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var follower: UILabel = {
        let l = UILabel()
        l.text = "followers"
        l.font = .systemFont(ofSize: 12, weight: .regular)
        l.textColor = .lightGray
        l.numberOfLines = 0
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var dot: UILabel = {
        let l = UILabel()
        l.text = "·"
        l.font = .systemFont(ofSize: 20, weight: .regular)
        l.textColor = .white
        l.numberOfLines = 0
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var followingNumber: UILabel = {
        let l = UILabel()
        l.text = "10"
        l.font = .systemFont(ofSize: 12, weight: .regular)
        l.textColor = .white
        l.numberOfLines = 0
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var following: UILabel = {
        let l = UILabel()
        l.text = "following"
        l.font = .systemFont(ofSize: 12, weight: .regular)
        l.textColor = .lightGray
        l.numberOfLines = 0
        l.textAlignment = .left
        l.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showFollowingArtists)))
        l.isUserInteractionEnabled = true
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var playlist: UILabel = {
        let l = UILabel()
        l.text = "Playlists"
        l.font = .systemFont(ofSize: 20, weight: .bold)
        l.textColor = .white
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var table: UITableView = {
        let t = UITableView()
        t.backgroundColor = .clear
        t.isScrollEnabled = false
        t.dataSource = self
        t.delegate = self
        t.register(PlaylistCell.self, forCellReuseIdentifier: "\(PlaylistCell.self)")
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private lazy var seeAllPlaylistButton: UIButton = {
        let b = UIButton(type: .custom)
        b.setTitle( "See all playlists", for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 16
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor.lightGray.cgColor
        b.addTarget(self, action: #selector(showAllPlaylists), for: .touchUpInside)
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
    
    private let viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getAllData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func setupUI() {
        setupGradientLayer()
        [indicatorview,
         image,
         name,
         email,
         followView,
         playlist,
         table,
         seeAllPlaylistButton].forEach { view.addSubview($0) }
        
        [followerNumber,
         follower,
         dot,
         followingNumber,
         following].forEach { followView.addSubview($0) }
        indicatorview.frame = view.bounds
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(showOptions))
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            image.widthAnchor.constraint(equalToConstant: 100),
            image.heightAnchor.constraint(equalToConstant: 100),
            
            name.topAnchor.constraint(equalTo: image.topAnchor, constant: 12),
            name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4),
            email.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            email.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            
            followView.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 8),
            followView.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            followView.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            followView.heightAnchor.constraint(equalToConstant: 12),
            
            followerNumber.centerYAnchor.constraint(equalTo: followView.centerYAnchor),
            followerNumber.leadingAnchor.constraint(equalTo: followView.leadingAnchor),
            
            follower.centerYAnchor.constraint(equalTo: followView.centerYAnchor),
            follower.leadingAnchor.constraint(equalTo: followerNumber.trailingAnchor, constant: 2),
            
            dot.centerYAnchor.constraint(equalTo: followView.centerYAnchor),
            dot.leadingAnchor.constraint(equalTo: follower.trailingAnchor, constant: 2),
            
            followingNumber.centerYAnchor.constraint(equalTo: followView.centerYAnchor),
            followingNumber.leadingAnchor.constraint(equalTo: dot.trailingAnchor, constant: 2),
            
            following.centerYAnchor.constraint(equalTo: followView.centerYAnchor),
            following.leadingAnchor.constraint(equalTo: followingNumber.trailingAnchor, constant: 2),
            
            playlist.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 40),
            playlist.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            playlist.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            
            table.topAnchor.constraint(equalTo: playlist.bottomAnchor, constant: 16),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.heightAnchor.constraint(equalToConstant: 200),
            
            seeAllPlaylistButton.topAnchor.constraint(equalTo: table.bottomAnchor, constant: 28),
            seeAllPlaylistButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            seeAllPlaylistButton.heightAnchor.constraint(equalToConstant: 32),
            seeAllPlaylistButton.widthAnchor.constraint(equalToConstant: 100)
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
                self?.table.reloadData()
            case .error(let error):
                self?.showAlert(message: error)
            case .idle:
                break
            }
        }
    }
    
    @objc private func showFollowingArtists() {
        let controller = FollowingArtistsController(viewModel: .init(useCase: UserManager()))
        navigationController?.show(controller, sender: nil)
    }
    
    @objc private func showAllPlaylists() {
        let controller = PlaylistsListController(viewModel: .init(playLists: viewModel.playlists))
        navigationController?.show(controller, sender: nil)
    }
    
    @objc private func showOptions() {
        guard let user = viewModel.user else { return }
        let controller = SettingsController(viewModel: .init(user: user))
        let navController = UINavigationController(rootViewController: controller)

        if let sheet = navController.sheetPresentationController {
            sheet.detents = [
                .custom { _ in return 150 }
            ]
            sheet.prefersGrabberVisible = true 
            sheet.preferredCornerRadius = 20
        }
        controller.delegate = self

        present(navController, animated: true)
    }
    
//    MARK: - Configure user info
    
    private func configureUserInfo() {
        self.load(image: image, url: viewModel.user?.images?.first?.url ?? "")
        name.text = viewModel.user?.displayName
        email.text = viewModel.user?.email
        followerNumber.text = "\(viewModel.user?.followers?.total ?? 0)"
        followingNumber.text = "\(viewModel.artists.count)"
    }
}

//MARK: - Configure TableView

extension ProfileController: UITableViewDataSource, UITableViewDelegate {
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
        let coordinator = PlaylistCoordinator(navigationController: self.navigationController ?? UINavigationController(),
                                              id: viewModel.playlists[indexPath.item].id ?? "")
        coordinator.start()
    }
}

extension ProfileController: SettingsProtocol {
    func didTapLogout() {
        let alert = UIAlertController(title: "LogOut",
                                      message: "Do you want to logout?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive) { [weak self] _ in
            AuthManager.shared.logout()
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let sceneDelegate = windowScene.delegate as? SceneDelegate else { return }
            sceneDelegate.welcomeRoot()
        })
        present(alert, animated: true)
    }
}
