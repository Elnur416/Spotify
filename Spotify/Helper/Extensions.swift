//
//  Extensions.swift
//  Spotify
//
//  Created by Elnur Mammadov on 24.03.25.
//

import UIKit
import Foundation

extension UIViewController {
    func showAlert(title: String? = "Error",
                   message: String? = "",
                   action: String? = "Dismiss") {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action,
                                      style: .cancel))
        present(alert, animated: true)
    }
}
