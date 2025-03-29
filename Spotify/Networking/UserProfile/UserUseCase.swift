//
//  UserUseCase.swift
//  Spotify
//
//  Created by Elnur Mammadov on 29.03.25.
//

import Foundation

protocol UserUseCase {
    func getCurrentUserProfile(completion: @escaping ((UserProfile?, String?) -> Void))
}
