//
//  SettingsViewModel.swift
//  Spotify
//
//  Created by Elnur Mammadov on 06.04.25.
//

import Foundation

struct SettingsModel {
    let imageName: String
    let title: String
}

class SettingsViewModel {
    var user: UserProfile?
    var items: [SettingsModel] = [.init(imageName: "person.crop.circle.badge.plus", title: "Register new user"),
                                  .init(imageName: "person.crop.circle.badge.minus", title: "Log out")]
    
    init(user: UserProfile) {
        self.user = user
    }
}
