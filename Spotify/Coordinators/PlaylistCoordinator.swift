//
//  PlaylistCoordinator.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.04.25.
//

import Foundation
import UIKit

final class PlaylistCoordinator: Coordinator {
    var navigationController: UINavigationController
    var id: String
    
    init(navigationController: UINavigationController, id: String) {
        self.navigationController = navigationController
        self.id = id
    }
    
    func start() {
        let controller = PlaylistController(viewModel: .init(playlistID: id, useCase: PlaylistManager()))
        navigationController.show(controller, sender: nil)
    }
}
