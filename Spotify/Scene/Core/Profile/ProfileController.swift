//
//  ProfileController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import UIKit

class ProfileController: BaseController {
    
    private let viewModel = ProfileViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getCurrentUser()
    }
    
    override func setupUI() {
        title = "Profile" 
    }
    
    override func configureViewModel() {
        viewModel.success = {
            
        }
        viewModel.errorHandler = { [weak self] error in
            self?.showAlert(message: error)
        }
    }
}
