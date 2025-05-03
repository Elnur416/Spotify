//
//  PlayerControlsView.swift
//  Spotify
//
//  Created by Elnur Mammadov on 03.05.25.
//

import Foundation
import UIKit

protocol PlayerControlsViewDelegate: AnyObject {
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapBackwardsButton(_ playerControlsView: PlayerControlsView)
    func playerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float)
}

struct PlayerControlsViewModel {
    let title: String?
    let subtitle: String?
}

final class PlayerControlsView: UIView {

    private var isPlaying = true

    weak var delegate: PlayerControlsViewDelegate?

    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "This Is My Song"
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Drake (feat. Some Other Artist)"
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let backButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "backward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let nextButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "forward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let playPauseButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [backButton, playPauseButton, nextButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        [nameLabel,
         subtitleLabel,
         volumeSlider,
         stack].forEach { addSubview($0) }
        
        volumeSlider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        
        clipsToBounds = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            subtitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            subtitleLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            volumeSlider.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 32),
            volumeSlider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            volumeSlider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            volumeSlider.heightAnchor.constraint(equalToConstant: 44),
            
            stack.topAnchor.constraint(equalTo: volumeSlider.bottomAnchor, constant: 32),
            stack.leadingAnchor.constraint(equalTo: volumeSlider.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: volumeSlider.trailingAnchor)
        ])
    }

    @objc func didSlideSlider(_ slider: UISlider) {
        let value = slider.value
        delegate?.playerControlsView(self, didSlideSlider: value)
    }

    @objc private func didTapBack() {
        delegate?.playerControlsViewDidTapBackwardsButton(self)
    }

    @objc private func didTapNext() {
        delegate?.playerControlsViewDidTapForwardButton(self)
    }

    @objc private func didTapPlayPause() {
        self.isPlaying = !isPlaying
        delegate?.playerControlsViewDidTapPlayPauseButton(self)

        // Update icon
        let pause = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        let play = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))

        playPauseButton.setImage(isPlaying ? pause : play, for: .normal)
    }

    func configure(with viewModel: PlayerControlsViewModel) {
//        nameLabel.text = viewModel.title
//        subtitleLabel.text = viewModel.subtitle
    }
}
