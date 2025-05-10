//
//  PlaylistController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import UIKit

class PlaylistController: BaseController {
    
//    MARK: UI elements
    
    private lazy var backButton: UIButton = {
        let b = UIButton(type: .custom)
        b.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        b.tintColor = .white
        b.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        b.backgroundColor = .clear
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private lazy var table: UITableView = {
       let t = UITableView()
        t.showsVerticalScrollIndicator = false
        t.backgroundColor = .clear
        t.register(TrackInPlaylistCell.self, forCellReuseIdentifier: "\(TrackInPlaylistCell.self)")
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
    
    private var loadingView: UIView?
    
//    MARK: - Properties
    
    private let viewModel: PlaylistViewModel
    
    init(viewModel: PlaylistViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getPlaylist()
        configureHeaderView()
    }
    
    override func setupUI() {
        setupGradientLayer()
        navigationController?.navigationBar.isHidden = true
        [indicatorview,
         table,
         backButton].forEach { view.addSubview($0) }
        indicatorview.frame = view.bounds
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
    
    private func configureHeaderView() {
        let header = TableHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 370))
        table.tableHeaderView = header
    }
    
    private func configureData() {
        guard let data = viewModel.playlist,
              let header = table.tableHeaderView as? TableHeaderView else { return }
        header.configure(model: data, type: .playlist)
        header.editActionHandler = { [weak self] in
            let controller = EditPlaylistController()
            controller.configureData(imageURL: self?.viewModel.playlist?.images?.first?.url ?? "",
                                     playlistName: self?.viewModel.playlist?.name ?? "")
            controller.saveActionCallBack = { [weak self] name in
                self?.showLoading(duration: 20)
                self?.viewModel.saveChanges(name: name)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
                    self?.table.reloadData()
                }
            }
            self?.present(controller, animated: true)
        }
    }
    
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func showLoading(duration: TimeInterval = 40.0) {
        let loading = UIView(frame: view.bounds)
        loading.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = loading.center
        indicator.startAnimating()
        
        loading.addSubview(indicator)
        view.addSubview(loading)
        
        loadingView = loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.hideLoading()
        }
    }
    
    private func hideLoading() {
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
}

extension PlaylistController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Int(viewModel.playlist?.tracks?.total ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(TrackInPlaylistCell.self)") as! TrackInPlaylistCell
        guard let data = viewModel.playlist?.tracks?.items?[indexPath.item].track else { return cell }
        cell.configure(model: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        66
    }
}
