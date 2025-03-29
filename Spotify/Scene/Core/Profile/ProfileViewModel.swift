//
//  ProfileViewModel.swift
//  Spotify
//
//  Created by Elnur Mammadov on 25.03.25.
//

import Foundation

final class ProfileViewModel {
    private(set) var user: UserProfile?
    private let useCase: UserUseCase
    var success: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    
    init(useCase: UserUseCase) {
        self.useCase = useCase
    }
    
    func getCurrentUser2() {
        useCase.getCurrentUserProfile { data, error in
            if let data {
                self.user = data
                self.success?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
}
