//
//  ArtistCoordinator.swift
//  Spotify
//
//  Created by Elnur Mammadov on 23.04.25.
//

import UIKit
import Foundation

final class ArtistCoordinator: Coordinator {
    var navigationController: UINavigationController
    var actorID: String
    
    init(navigationController: UINavigationController, actorID: String) {
        self.navigationController = navigationController
        self.actorID = actorID
    }
    
    func start() {
        let controller = ArtistController(viewModel: .init(actorID: actorID,
                                                           useCase: ArtistManager(),
                                                           trackUseCase: TrackManager()))
        navigationController.show(controller, sender: nil)
    }
}
