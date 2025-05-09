//
//  AddController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 09.05.25.
//

import UIKit

protocol AddControllerDelegate: AnyObject {
    func addToPlaylist()
    func saveTrack()
}

class AddController: BaseController {
    
//    MARK: UI elements
  
    private lazy var addPlaylistButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("  Add Playlist", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "plus.app"), for: .normal)
        button.layer.borderColor = UIColor.green2.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(handleAddPlaylist), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var saveTrackButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("  Save Track", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        button.layer.borderColor = UIColor.green2.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(handleSaveTrack), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [addPlaylistButton, saveTrackButton])
        s.axis = .vertical
        s.spacing = 20
        s.distribution = .fillEqually
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
//    MARK: - Properties
    
    var delegate: AddControllerDelegate?
    
//    MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func setupUI() {
        view.backgroundColor = .black
        view.addSubview(stack)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            addPlaylistButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.87),
            addPlaylistButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.22),
            
            saveTrackButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.87),
            saveTrackButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.22),
        ])
    }
    
    @objc private func handleAddPlaylist() {
        dismiss(animated: true)
        delegate?.addToPlaylist()
    }
    
    @objc private func handleSaveTrack() {
        dismiss(animated: true)
        delegate?.saveTrack()
    }
}
