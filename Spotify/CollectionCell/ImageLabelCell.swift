//
//  ImageLabelCell.swift
//  Spotify
//
//  Created by Elnur Mammadov on 31.03.25.
//

import UIKit

class ImageLabelCell: UICollectionViewCell {
    
//    MARK: UI elements
    
    private lazy var image: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = UIColor(named: "green2")
        i.layer.cornerRadius = 8
        i.clipsToBounds = true
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var name: UILabel = {
        let l = UILabel()
        l.textColor = .lightGray
        l.text = "Semicenk, Sezen Aksu, Sefo and more"
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.numberOfLines = 2
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
        [image,
         name].forEach { addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.heightAnchor.constraint(equalToConstant: 150),
            image.widthAnchor.constraint(equalToConstant: 150),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            name.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            name.leadingAnchor.constraint(equalTo: leadingAnchor),
            name.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configure(model: HomeDataProtocol, type: HomeDataType) {
        if type == .artist {
            image.layer.cornerRadius = 75
            name.textAlignment = .center
        }
        load(image: image, url: model.imageURL)
        name.text = model.nameText
    }
}
