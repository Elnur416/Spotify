//
//  SettingsViewModel.swift
//  Spotify
//
//  Created by Elnur Mammadov on 06.04.25.
//

import Foundation

enum SettingsTitle: String {
    case logOut = "Log out"
}

struct SettingsModel {
    let imageName: String
    let title: SettingsTitle
}

class SettingsViewModel {
    var user: UserProfile?
    var items: [SettingsModel] = [.init(imageName: "person.crop.circle.badge.minus", title: .logOut)]
    
    init(user: UserProfile) {
        self.user = user
    }
}
