//
//  Coordinator.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import UIKit
import Foundation

public protocol Coordinator {
    var navigationController: UINavigationController { get }
    
    func start()
}
