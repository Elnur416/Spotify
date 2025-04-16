//
//  CategoryCell.swift
//  Spotify
//
//  Created by Elnur Mammadov on 06.04.25.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
//    MARK: UI elements
    
    private lazy var alphaView: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        v.alpha = 0.5
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var image: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .gray
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var name: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .bold)
        l.textColor = .white
        l.numberOfLines = 1
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
//    MARK: - Properties
    
    private let colors: [UIColor] = [.red, .green, .blue, .yellow, .orange, .purple, .brown, .gray, .lightGray, .darkGray, .cyan, .magenta, .systemTeal]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .gray
        layer.cornerRadius = 8
        [alphaView,
         image,
         name].forEach { addSubview($0) }
        alphaView.frame = bounds
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            image.widthAnchor.constraint(equalToConstant: 60),
            image.heightAnchor.constraint(equalToConstant: 60),
            
            name.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    func configure(model: CategoryItem) {
        load(image: image, url: model.icons?.first?.url ?? "")
        name.text = model.name
        backgroundColor = colors.randomElement()
    }
}
