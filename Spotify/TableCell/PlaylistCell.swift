//
//  PlaylistCell.swift
//  Spotify
//
//  Created by Elnur Mammadov on 31.03.25.
//

import UIKit

class PlaylistCell: UITableViewCell {
    
//    MARK: Ui elements
    
    private lazy var image: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .gray
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
    
    private lazy var tracksCount: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 12, weight: .regular)
        l.textColor = .lightGray
        l.textAlignment = .left
        l.numberOfLines = 0
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
    
    private lazy var ownerName: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 12, weight: .regular)
        l.textColor = .lightGray
        l.text = "Elnur Mammaedov"
        l.textAlignment = .left
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

//    MARK: - Life cycle
    
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
         tracksCount,
         dot,
         ownerName].forEach { addSubview($0) }
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
            
            tracksCount.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 8),
            tracksCount.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            
            dot.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 2),
            dot.leadingAnchor.constraint(equalTo: tracksCount.trailingAnchor, constant: 8),

            ownerName.topAnchor.constraint(equalTo: tracksCount.topAnchor),
            ownerName.leadingAnchor.constraint(equalTo: dot.trailingAnchor, constant: 8)
        ])
    }
    
//    MARK: - Configure data
    
    func configure(model: PlaylistItem) {
        load(image: image, url: model.images?.first?.url ?? "")
        name.text = model.name
        tracksCount.text = "\(model.tracks?.total ?? 0) tracks"
        ownerName.text = model.owner?.displayName
    }
}
