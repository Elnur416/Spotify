//
//  ArtistController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 19.04.25.
//

import UIKit

class ArtistController: BaseController {
    
//    MARK: UI elements
    
    private lazy var table: UITableView = {
       let t = UITableView()
        t.showsVerticalScrollIndicator = false
        t.backgroundColor = .clear
        t.register(TrackInAlbumCell.self, forCellReuseIdentifier: "\(TrackInAlbumCell.self)")
        t.dataSource = self
        t.delegate = self
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private lazy var indicatorview: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.style = .medium
        view.color = .gray
        return view
    }()
    
//    MARK: - Properties
    
    private let viewModel: ArtistViewModel
    
    init(viewModel: ArtistViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getArtistInfo()
        configureTableHeader()
    }
    
    override func setupUI() {
        setupGradientLayer()
        [indicatorview,
         table].forEach { view.addSubview($0) }
        indicatorview.frame = view.bounds
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func configureViewModel() {
        viewModel.stateUpdated = { [weak self] state in
            switch state {
            case .loading:
                self?.indicatorview.startAnimating()
            case .loaded:
                self?.indicatorview.stopAnimating()
            case .success:
                self?.configureData()
                self?.table.reloadData()
            case .error(let error):
                self?.showAlert(message: error)
            case .idle:
                break
            }
        }
    }
    
    private func configureData() {
        guard let data = viewModel.artist,
        let header = table.tableHeaderView as? ArtistTableHeaderView else { return }
        header.configure(model: data)
    }
    
    private func configureTableHeader() {
        let header = ArtistTableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 370))
        table.tableHeaderView = header
    }
}

extension ArtistController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(TrackInAlbumCell.self)") as! TrackInAlbumCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        .init(66)
    }
}
