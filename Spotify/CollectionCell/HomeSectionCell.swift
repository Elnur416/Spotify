//
//  HeaderSectionCell.swift
//  Spotify
//
//  Created by Elnur Mammadov on 31.03.25.
//

import UIKit

class HomeSectionCell: UICollectionViewCell {
    
//    MARK: UI elements
    
    private lazy var titleText: UILabel = {
        let l = UILabel()
        l.text = "New Release"
        l.textColor = .white
        l.font = .systemFont(ofSize: 24, weight: .bold)
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 12, bottom: 0, right: 0)
        layout.minimumLineSpacing = 16
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.dataSource = self
        c.delegate = self
        c.showsHorizontalScrollIndicator = false
        c.register(ImageLabelCell.self, forCellWithReuseIdentifier: "\(ImageLabelCell.self)")
        c.translatesAutoresizingMaskIntoConstraints = false
        return c
    }()
    
//    MARK: - Properties
    
    var data: DataType?
    var indexCallBack: ((HomeDataType, String) -> Void)?
    
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
         collection].forEach { addSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            collection.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 12),
            collection.leadingAnchor.constraint(equalTo: leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func configure(text: String, data: DataType) {
        self.titleText.text = text
        self.data = data
    }
}

extension HomeSectionCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data?.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ImageLabelCell.self)", for: indexPath) as! ImageLabelCell
        if let items = data?.items?[indexPath.item], let type = data?.type {
            cell.configure(model: items,
                           type: type)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 150, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if data?.type == .album {
            let id = data?.items?[indexPath.item].itemId ?? ""
            indexCallBack?(.album, id)
        } else if data?.type == .artist {
            let id = data?.items?[indexPath.item].itemId ?? ""
            indexCallBack?(.artist, id)
        }
    }
}
