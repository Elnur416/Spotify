//
//  ProfileViewModel.swift
//  Spotify
//
//  Created by Elnur Mammadov on 25.03.25.
//

import Foundation

final class ProfileViewModel {
    private(set) var user: UserProfile?
    var success: (() -> Void)?
    var errorHandler: ((String) -> Void)?
    
    func getCurrentUser() {
        ApiCaller.shared.getCurrentUserProfile { data, error in
            if let data {
                self.user = data
                self.success?()
            } else if let error {
                self.errorHandler?(error)
            }
        }
    }
}
