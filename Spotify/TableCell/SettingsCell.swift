//
//  SettingsCell.swift
//  Spotify
//
//  Created by Elnur Mammadov on 06.04.25.
//

import UIKit

class SettingsCell: UITableViewCell {
    
//    MARK: UI elements
    
    private lazy var image: UIImageView = {
        let i = UIImageView()
        i.tintColor = .white
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var name: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
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
        [image,
         name].forEach { addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 24),
            image.heightAnchor.constraint(equalToConstant: 24),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            
            name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 8),
            name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            name.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configure(model: SettingsModel) {
        if model.title == .logOut {
            name.textColor = .red
        }
        image.image = UIImage(systemName: model.imageName)
        name.text = model.title.rawValue
    }
}
