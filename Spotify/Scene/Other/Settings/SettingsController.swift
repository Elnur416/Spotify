//
//  SettingsController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import UIKit

protocol SettingsProtocol: AnyObject {
    func didTapLogout()
}

class SettingsController: BaseController {
    
//    MARK: UI elements
    
    private lazy var image: UIImageView = {
       let i = UIImageView()
        i.backgroundColor = .gray
        i.layer.cornerRadius = 25
        i.clipsToBounds = true
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    private lazy var name: UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.font = .systemFont(ofSize: 17, weight: .medium)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var table: UITableView = {
        let t = UITableView()
        t.isScrollEnabled = false
        t.backgroundColor = .clear
        t.dataSource = self
        t.delegate = self
        t.register(SettingsCell.self, forCellReuseIdentifier: "\(SettingsCell.self)")
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
//    MARK: - Properties
    
    private let viewModel: SettingsViewModel
    var delegate: SettingsProtocol?
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUserData()
    }
    
    override func setupUI() {
        view.backgroundColor = .black2
        navigationController?.navigationBar.isHidden = true
        [image,
         name,
         table].forEach(view.addSubview)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            image.widthAnchor.constraint(equalToConstant: 50),
            image.heightAnchor.constraint(equalToConstant: 50),
            
            name.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            name.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 12),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            table.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUserData() {
        load(image: image, url: viewModel.user?.images?.first?.url ?? "")
        name.text = viewModel.user?.displayName
    }
}

extension SettingsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(SettingsCell.self)", for: indexPath) as! SettingsCell
        cell.configure(model: viewModel.items[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.items[indexPath.item].title == .logOut {
            dismiss(animated: true) { [weak self] in
                self?.delegate?.didTapLogout()
            }
        }
    }
}
