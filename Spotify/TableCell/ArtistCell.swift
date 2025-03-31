//
//  ArtistCell.swift
//  Spotify
//
//  Created by Elnur Mammadov on 31.03.25.
//

import UIKit

class ArtistCell: UITableViewCell {
    
//    MARK: UI elements
    
    private lazy var image: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .gray
        i.layer.cornerRadius = 25
        i.clipsToBounds = true
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var name: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 17, weight: .medium)
        l.textColor = .white
        l.textAlignment = .left
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var followers: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 12, weight: .regular)
        l.textColor = .lightGray
        l.textAlignment = .left
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var icon: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        b.tintColor = .green
        b.addTarget(self, action: #selector(unfollowArtist), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        [image,
         name,
         followers,
         icon].forEach { contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 50),
            image.heightAnchor.constraint(equalToConstant: 50),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            name.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            followers.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8),
            followers.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            followers.trailingAnchor.constraint(equalTo: name.trailingAnchor),
            
            icon.centerYAnchor.constraint(equalTo: centerYAnchor),
            icon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            icon.widthAnchor.constraint(equalToConstant: 20),
            icon.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc private func unfollowArtist() {
        icon.isSelected.toggle()
        
        let imageName = icon.isSelected ? "person.badge.plus" : "checkmark.circle"
        let color = icon.isSelected ? UIColor.lightGray : UIColor.green
        
        icon.setImage(UIImage(systemName: imageName), for: .normal)
        icon.tintColor = color
    }
    
    func configure(model: ArtistInfo) {
        load(image: image, url: "\(model.images?.first?.url ?? "")")
        name.text = model.name
        followers.text = "\(model.followers?.total ?? 0) followers"
    }
}
