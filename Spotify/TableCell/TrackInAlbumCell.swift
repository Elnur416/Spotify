//
//  TrackInAlbumCell.swift
//  Spotify
//
//  Created by Elnur Mammadov on 19.04.25.
//

import UIKit

class TrackInAlbumCell: UITableViewCell {
    
//    MARK: UI elements
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 17, weight: .medium)
        l.numberOfLines = 1
        l.textColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var subLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 12, weight: .regular)
        l.numberOfLines = 1
        l.textColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var addButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        b.tintColor = .white
        b.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
//    MARK: - Properties
    
    var addCallBack: (() -> Void)?

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
        [titleLabel,
        subLabel,
         addButton].forEach { contentView.addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 28),
            titleLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -12),

            subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -28),
            addButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func addAction() {
        addCallBack?()
    }
    
    func configure(model: TrackProtocol) {
        titleLabel.text = model.trackName
        subLabel.text = model.subInfo
    }
}
