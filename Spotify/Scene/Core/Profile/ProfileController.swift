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
        
        viewModel.getCurrentUser()
        viewModel.getUserPlaylists()
    }
    
    override func setupUI() {
        title = "Profile"
        setupGradientLayer()
        [indicatorview,
         image,
         name,
         email,
         followView,
         playlist].forEach { view.addSubview($0) }
        
        [followerNumber,
         follower,
         dot,
         followingNumber,
         following].forEach { followView.addSubview($0) }
        indicatorview.frame = view.bounds
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
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
            playlist.trailingAnchor.constraint(equalTo: name.trailingAnchor)
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
                print(self?.viewModel.playlists)
            case .error(let error):
                self?.showAlert(message: error)
            case .idle:
                break
            }
        }
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.gradient.cgColor, UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        view.layer.addSublayer(gradientLayer)
    }
    
    private func configureUserInfo() {
        self.load(image: image, url: viewModel.user?.images?.first?.url ?? "")
        name.text = viewModel.user?.displayName
        email.text = viewModel.user?.email
    }
}
