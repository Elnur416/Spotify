//
//  LoginCoordinator.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import UIKit
import Foundation

final class LoginCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = AuthController()
        navigationController.show(controller, sender: nil)
    }
}
