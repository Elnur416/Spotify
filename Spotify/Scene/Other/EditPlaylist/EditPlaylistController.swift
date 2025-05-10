//
//  EditPlaylistController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 10.05.25.
//

import UIKit

class EditPlaylistController: BaseController {
    
//    MARK: UI elements
    
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Edit Playlist"
        l.textColor = .white
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
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
    
    private lazy var image: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .systemGray
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var changeImageButton: UIButton = {
        let b = UIButton(type: .custom)
        b.setTitle( "Change Image", for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        b.setTitleColor(.white, for: .normal)
        b.layer.cornerRadius = 12
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor.lightGray.cgColor
        b.addTarget(self, action: #selector(changeImageAction), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
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
    
    private lazy var saveButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Save", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.backgroundColor = .green2
        b.layer.cornerRadius = 16
        b.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        b.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private let imagePicker = UIImagePickerController()
    
//    MARK: - Properties

    var saveActionCallBack: ((String) -> Void)?
    
//    MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func setupUI() {
        view.backgroundColor = .black
        [titleLabel,
         cancelButton,
         image,
        changeImageButton,
        nameTextField,
        line,
        saveButton].forEach { view.addSubview($0) }
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cancelButton.heightAnchor.constraint(equalToConstant: 32),
            cancelButton.widthAnchor.constraint(equalToConstant: 100),
            
            titleLabel.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor, constant: -20),
            
            image.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 40),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 150),
            image.heightAnchor.constraint(equalToConstant: 150),
            
            changeImageButton.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20),
            changeImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeImageButton.widthAnchor.constraint(equalToConstant: 150),
            changeImageButton.heightAnchor.constraint(equalToConstant: 24),
            
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: changeImageButton.bottomAnchor, constant: 40),
            nameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.74),
            
            line.widthAnchor.constraint(equalTo: nameTextField.widthAnchor),
            line.heightAnchor.constraint(equalToConstant: 1),
            line.topAnchor.constraint(equalTo: nameTextField.bottomAnchor),
            line.centerXAnchor.constraint(equalTo: nameTextField.centerXAnchor),
            
            saveButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 40),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    @objc private func cancelAction() {
        dismiss(animated: true)
    }
    
    @objc private func saveAction() {
        guard let name = nameTextField.text, !name.isEmpty else {
            self.showAlert(message: "Please enter name")
            return
        }
        saveActionCallBack?(name)
        dismiss(animated: true)
    }
    
    @objc private func changeImageAction() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func configureData(imageURL: String, playlistName: String) {
        load(image: image, url: imageURL)
        nameTextField.text = playlistName
    }
}

extension EditPlaylistController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        image.image = pickedImage
        picker.dismiss(animated: true, completion: nil)
    }
}
