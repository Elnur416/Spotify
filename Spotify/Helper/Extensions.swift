//
//  Extensions.swift
//  Spotify
//
//  Created by Elnur Mammadov on 24.03.25.
//

import UIKit
import Foundation
import SDWebImage

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

extension UIViewController {
    func load(image: UIImageView, url: String) {
        image.sd_setImage(with: URL(string: url))
    }
}

extension UITableViewCell {
    func load(image: UIImageView, url: String) {
        image.sd_setImage(with: URL(string: url))
    }
}

extension UICollectionViewCell {
    func load(image: UIImageView, url: String) {
        image.sd_setImage(with: URL(string: url))
    }
}

extension UIView {
    func loadImage(image: UIImageView, url: String) {
        image.sd_setImage(with: URL(string: url))
    }
}

extension UINavigationController {
    public override var navigationController: UINavigationController? {
        navigationBar.tintColor = .white
        return self
    }
}

extension UIViewController {
    func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.gradient.cgColor, UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        view.layer.addSublayer(gradientLayer)
    }
}
