//
//  CreatePlaylistController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 10.05.25.
//

import UIKit

class CreatePlaylistController: BaseController {
    
//    MARK: UI elements
    
    private lazy var cancelButton: UIButton = {
        let b = UIButton(type: .custom)
        b.setTitle( "Cancel", for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 16
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor.lightGray.cgColor
        b.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Give your playlist a name"
        l.textColor = .white
        l.font = .systemFont(ofSize: 28, weight: .bold)
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var nameTextField: UITextField = {
        let t = UITextField()
        t.borderStyle = .none
        t.placeholder = "Playlist name"
        t.textColor = .white
        t.returnKeyType = .done
        t.font = .systemFont(ofSize: 20, weight: .medium)
        t.textAlignment = .center
        t.backgroundColor = .clear
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private lazy var line: UIView = {
        let v = UIView()
        v.backgroundColor = .gray
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var createButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Create", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.backgroundColor = .green2
        b.layer.cornerRadius = 16
        b.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        b.addTarget(self, action: #selector(createPlaylistAction), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
//    MARK: - Properties
    
    var createPlaylistCallBack: ((String) -> Void)?
    
//    MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func setupUI() {
        view.backgroundColor = .black
        [cancelButton,
         titleLabel,
         nameTextField,
         line,
         createButton].forEach { view.addSubview($0) }
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cancelButton.heightAnchor.constraint(equalToConstant: 32),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            nameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.74),
            
            line.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            line.heightAnchor.constraint(equalToConstant: 1),
            line.topAnchor.constraint(equalTo: nameTextField.bottomAnchor),
            line.centerXAnchor.constraint(equalTo: nameTextField.centerXAnchor),
            
            createButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40),
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    @objc private func cancelAction() {
        dismiss(animated: true)
    }
    
    @objc private func createPlaylistAction() {
        guard let name = nameTextField.text, !name.isEmpty else { return }
        createPlaylistCallBack?(name)
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
    }
}
