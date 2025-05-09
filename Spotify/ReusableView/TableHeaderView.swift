//
//  TableHeaderView.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import UIKit

enum HeaderType {
    case album
    case playlist
}

class TableHeaderView: UIView {
    
//    MARK: UI elements
    
    private lazy var image: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .gray
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.text = "Spotify"
        l.font = .systemFont(ofSize: 20, weight: .bold)
        l.numberOfLines = 1
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var subLabel: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.text = "Elnur Mammadov"
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.numberOfLines = 1
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var editButton: UIButton = {
        let b = UIButton(type: .custom)
        b.setImage(UIImage(systemName: "pencil"), for: .normal)
        b.setTitle(" Edit", for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        b.tintColor = .white
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = .clear
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor.white.cgColor
        b.layer.cornerRadius = 14
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private lazy var saveButton: UIButton = {
        let b = UIButton(type: .custom)
        b.setImage(UIImage(systemName: "plus.app"), for: .normal)
        b.setTitle(" Save", for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        b.tintColor = .white
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = .clear
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor.white.cgColor
        b.layer.cornerRadius = 14
        b.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
//    MARK: - Properties
    
    var saveActionHandler: (() -> Void)?
    
    
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
        [image,
        titleLabel,
        subLabel,
        editButton,
        saveButton].forEach { addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 250),
            image.heightAnchor.constraint(equalToConstant: 250),
            image.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            editButton.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 8),
            editButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 100),
            editButton.heightAnchor.constraint(equalToConstant: 28),
            
            saveButton.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: 8),
            saveButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 100),
            saveButton.heightAnchor.constraint(equalToConstant: 28),
        ])
    }
    
    @objc private func saveAction() {
        saveActionHandler?()
    }
    
    func configure(model: HeaderProtocol, type: HeaderType) {
        loadImage(image: image, url: model.mainImage)
        titleLabel.text = model.titleName
        subLabel.text = "\(model.ownerName) · \(model.totalTracksCount) songs"
        if type == .album {
            editButton.isHidden = true
            saveButton.isHidden = false
        } else if type == .playlist {
            editButton.isHidden = false
            saveButton.isHidden = true
        }
    }
}
