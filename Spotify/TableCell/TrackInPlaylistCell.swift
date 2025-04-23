//
//  TrackCell.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import UIKit

class TrackInPlaylistCell: UITableViewCell {
    
    private lazy var image: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .gray
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var trackName: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 17, weight: .medium)
        l.textColor = .white
        l.text = "Track Name"
        l.textAlignment = .left
        l.numberOfLines = 1
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var artistName: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 12, weight: .regular)
        l.textColor = .lightGray
        l.text = "Lana Del Rey"
        l.textAlignment = .left
        l.numberOfLines = 1
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

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        backgroundColor = .clear
        [image,
        trackName,
         artistName].forEach { contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 50),
            image.heightAnchor.constraint(equalToConstant: 50),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            trackName.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            trackName.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            trackName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            artistName.topAnchor.constraint(equalTo: trackName.bottomAnchor, constant: 8),
            artistName.leadingAnchor.constraint(equalTo: trackName.leadingAnchor),
            artistName.trailingAnchor.constraint(equalTo: trackName.trailingAnchor)
        ])
    }
    
    func configure(model: Track3) {
        load(image: image, url: model.album?.images?.first?.url ?? "")
        trackName.text = model.name
        artistName.text = model.artists?.first?.name
    }
}
