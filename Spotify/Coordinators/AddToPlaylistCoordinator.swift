//
//  AddToPlaylistCoordinator.swift
//  Spotify
//
//  Created by Elnur Mammadov on 09.05.25.
//

import Foundation
import UIKit

final class AddToPlaylistCoordinator: Coordinator {
    var navigationController: UINavigationController
    var trackURI: String
    
    init(navigationController: UINavigationController, trackURI: String) {
        self.navigationController = navigationController
        self.trackURI = trackURI
    }
    
    func start() {
        let controller = AddToPlaylistController(viewModel: .init(useCase: PlaylistManager(), trackURI: trackURI))
        navigationController.present(controller, animated: true)
    }
}
