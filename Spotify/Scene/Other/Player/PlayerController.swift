//
//  PlayerController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import UIKit

protocol PlayerViewControllerDelegate: AnyObject {
    func didTapPlayPause()
    func didTapForward()
    func didTapBackward()
    func didSlideSlider(_ value: Float)
}

class PlayerController: BaseController {

    weak var dataSource: PlayerDataSource?
    weak var delegate: PlayerViewControllerDelegate?

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let controlsView = PlayerControlsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func setupUI() {
        view.backgroundColor = .black
        setupGradientLayer()
        navigationController?.navigationBar.isHidden = true
        [imageView,
         controlsView].forEach { view.addSubview($0) }
        controlsView.translatesAutoresizingMaskIntoConstraints = false
        controlsView.delegate = self
        configure()
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor),
            
            controlsView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            controlsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controlsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            controlsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configure() {
        load(image: imageView, url: dataSource?.imageURL ?? "")
        controlsView.configure(
            with: PlayerControlsViewModel(
                title: dataSource?.songName,
                subtitle: dataSource?.subtitle
            )
        )
    }

    func refreshUI() {
        configure()
    }
}

extension PlayerController: PlayerControlsViewDelegate {
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapPlayPause()
    }

    func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapForward()
    }

    func playerControlsViewDidTapBackwardsButton(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapBackward()
    }

    func playerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float) {
        delegate?.didSlideSlider(value)
    }
}
