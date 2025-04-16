//
//  LibraryHeaderView.swift
//  Spotify
//
//  Created by Elnur Mammadov on 16.04.25.
//

import UIKit

struct LibrarySectionModel {
    let name: LibrarySectionNames
    var isSelected: Bool
}

enum LibrarySectionNames: String {
    case playlists = "Playlists"
    case albums = "Albums"
}

class LibraryHeaderView: UICollectionReusableView {
    
//    MARK: UI elements
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 30, bottom: 0, right: 0)
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.dataSource = self
        c.delegate = self
        c.register(LibrarySectionCell.self, forCellWithReuseIdentifier: "\(LibrarySectionCell.self)")
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
    private lazy var button: UIButton = {
        let b = UIButton(type: .custom)
        b.layer.cornerRadius = 8
        b.setTitle(" add Playlist", for: .normal)
        b.setImage(UIImage(systemName: "plus"), for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.tintColor = .white
        b.backgroundColor = UIColor(named: "green2")
        b.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
//    MARK: - Properties
    var sectionCallBack: ((LibrarySectionNames) -> Void)?
    
    private var sectionModels: [LibrarySectionModel] = [.init(name: .playlists, isSelected: true),
                                                        .init(name: .albums, isSelected: false)]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstrants()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        [collection,
         button].forEach { addSubview($0) }
    }
    
    private func setupConstrants() {
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: topAnchor),
            collection.trailingAnchor.constraint(equalTo: trailingAnchor),
            collection.leadingAnchor.constraint(equalTo: leadingAnchor),
            collection.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 30),
            button.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension LibraryHeaderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(LibrarySectionCell.self)", for: indexPath) as! LibrarySectionCell
        cell.configure(model: self.sectionModels[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 70, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for (index, _) in sectionModels.enumerated() {
            sectionModels[index].isSelected = index == indexPath.item ? true : false
        }
        collection.reloadData()
        self.sectionCallBack?(sectionModels[indexPath.item].name)
    }
}
