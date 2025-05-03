//
//  ArtistTableHeaderView.swift
//  Spotify
//
//  Created by Elnur Mammadov on 23.04.25.
//

import UIKit

class ArtistTableHeaderView: UIView {
    
//    MARK: Ui elements
    
    private lazy var image: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .gray
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var name: UILabel = {
        let l = UILabel()
        l.textAlignment = .left
        l.text = "Semicenk"
        l.numberOfLines = 1
        l.font = .systemFont(ofSize: 44, weight: .bold)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var followers: UILabel = {
        let l = UILabel()
        l.textAlignment = .left
        l.text = "113423242"
        l.numberOfLines = 1
        l.font = .systemFont(ofSize: 12, weight: .regular)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var followButton: UIButton = {
        let b = UIButton(type: .custom)
        b.setTitle("Follow", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        b.layer.cornerRadius = 14
        b.backgroundColor = .clear
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor.white.cgColor
        b.addTarget(self, action: #selector(followAction), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        return l
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        addSubview(image)
        layer.addSublayer(gradientLayer)
        [name,
         followers,
         followButton].forEach { addSubview($0) }
        
        gradientLayer.frame = bounds
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 370),
            
            followers.bottomAnchor.constraint(equalTo: image.bottomAnchor, constant: -8),
            followers.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            followers.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            name.bottomAnchor.constraint(equalTo: followers.topAnchor, constant: -8),
            name.leadingAnchor.constraint(equalTo: followers.leadingAnchor),
            name.trailingAnchor.constraint(equalTo: followers.trailingAnchor),
            
            followButton.bottomAnchor.constraint(equalTo: image.bottomAnchor, constant: -8),
            followButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            followButton.heightAnchor.constraint(equalToConstant: 28),
            followButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func configure(model: ArtistInfo) {
        loadImage(image: image, url: model.imageURL)
        name.text = model.titleName
        followers.text = "\(model.followersCount) followers"
    }
    
    @objc private func followAction() {
        followButton.setTitle("Following", for: .normal)
    }
}
