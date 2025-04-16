//
//  SearchResultsController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import UIKit

struct TableData {
    let title: SearchDataType
    let results: [SearchDataProtocol]
}

enum SearchDataType: String {
    case artist = "Artists"
    case tracks = "Songs"
}

class SearchResultsController: BaseController {
    
//    MARK: UI elements
    
    private lazy var table: UITableView = {
        let t = UITableView()
        t.showsVerticalScrollIndicator = false
        t.dataSource = self
        t.delegate = self
        t.register(ArtistCell.self, forCellReuseIdentifier: "\(ArtistCell.self)")
        t.backgroundColor = .black
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
//    MARK: - Properties
    
    private var sections = [TableData]()
    
//    MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func setupUI() {
        view.backgroundColor = .clear
        view.addSubview(table)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func updateData(items: SearchResults) {
        guard let tracks = items.tracks?.items,
              let artists = items.artists?.items else { return }
        self.sections.removeAll()
        let item = TableData(title: .tracks, results: tracks)
        let item2 = TableData(title: .artist, results: artists)
        self.sections.append(item)
        self.sections.append(item2)
        table.reloadData()
    }
}

extension SearchResultsController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ArtistCell.self)") as! ArtistCell
            cell.configure(model: sections[indexPath.section].results[indexPath.row], type: .search)
            return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title.rawValue
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        .init(66)
    }
}
