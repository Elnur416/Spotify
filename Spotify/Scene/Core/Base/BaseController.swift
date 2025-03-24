//
//  BaseController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        configureViewModel()
    }
    
    func setupUI() {}
    
    func setupConstraints() {}
    
    func configureViewModel() {}
}
