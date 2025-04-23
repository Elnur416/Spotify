//
//  LibrarySectionCell.swift
//  Spotify
//
//  Created by Elnur Mammadov on 16.04.25.
//

import UIKit

class LibrarySectionCell: UICollectionViewCell {
    
    private lazy var titleText: UILabel = {
        let t = UILabel()
        t.textColor = .white
        t.font = .systemFont(ofSize: 14, weight: .medium)
        t.textAlignment = .center
        t.text = "Playlists"
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private lazy var line: UIImageView = {
        let l = UIImageView()
        l.backgroundColor = UIColor(named: "green2")
        l.translatesAutoresizingMaskIntoConstraints = false
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
        [titleText,
         line].forEach { addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleText.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleText.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            line.bottomAnchor.constraint(equalTo: bottomAnchor),
            line.leadingAnchor.constraint(equalTo: leadingAnchor),
            line.trailingAnchor.constraint(equalTo: trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configure(model: LibrarySectionModel) {
        titleText.text = model.name.rawValue
        line.backgroundColor = model.isSelected == true ? UIColor(named: "green2") : .clear
    }
}
