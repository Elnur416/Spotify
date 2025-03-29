//
//  ProfileController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import UIKit

class ProfileController: BaseController {
    
    private let viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getCurrentUser2()
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
