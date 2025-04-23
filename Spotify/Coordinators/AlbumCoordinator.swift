//
//  AlbumCoordinator.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import UIKit
import Foundation

final class AlbumCoordinator: Coordinator {
    var navigationController: UINavigationController
    var id: String
    
    init(navigationController: UINavigationController, id: String) {
        self.navigationController = navigationController
        self.id = id
    }
    
    func start() {
        let controller = AlbumController(viewModel: .init(id: id, useCase: AlbumManager()))
        navigationController.show(controller, sender: nil)
    }
}
