//
//  WelcomeController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import UIKit

class WelcomeController: BaseController {
    
//    MARK: UI elements
    
    private lazy var background: UIImageView = {
       let i = UIImageView(image: UIImage(named: "background"))
        i.contentMode = .scaleAspectFill
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var logo: UIImageView = {
       let i = UIImageView(image: UIImage(named: "logo2"))
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var text: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        l.textColor = .white
        l.numberOfLines = 0
        l.textAlignment = .center
        l.text = "Millions of songs free on Spotify"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var headphones: UIImageView = {
        let i = UIImageView(image: UIImage(named: "spotify"))
        i.contentMode = .scaleAspectFit
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var button: UIButton = {
        let b = UIButton(type: .custom)
        b.setTitle("Sign In with Spotify", for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        b.setTitleColor(.black, for: .normal)
        b.layer.cornerRadius = 30
        b.backgroundColor = UIColor(named: "green2")
        b.addTarget(self,
                    action: #selector(signIn),
                    for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

//    MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func setupUI() {
        view.backgroundColor = UIColor(named: "black2")
        [background,
         logo,
         text,
         headphones,
         button].forEach { view.addSubview($0) }
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            logo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.14),
            logo.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.bottomAnchor.constraint(equalTo: text.topAnchor, constant: -20),
            
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            headphones.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -20),
            headphones.topAnchor.constraint(equalTo: text.bottomAnchor, constant: 20),
            headphones.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headphones.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headphones.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
//    MARK: - Sign In
    
    @objc private func signIn() {
        let coordinator = LoginCoordinator(navigationController: self.navigationController ?? UINavigationController())
        coordinator.start()
    }
}
