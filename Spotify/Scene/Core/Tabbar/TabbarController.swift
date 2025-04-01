//
//  TabbarController.swift
//  Spotify
//
//  Created by Elnur Mammadov on 18.03.25.
//

import UIKit

class TabbarController: UITabBarController {
    
    private let vc1 = UINavigationController(rootViewController: HomeController(viewModel: .init(userUseCase: UserManager(), homeUseCase: HomeManager())))
    private let vc2 = UINavigationController(rootViewController: SearchController())
    private let vc3 = UINavigationController(rootViewController: LibraryController())
    private let vc4 = UINavigationController(rootViewController: ProfileController(viewModel: .init(useCase: UserManager())))

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabs()
    }
    
    private func configureTabs() {
        setTabTitles()
        setTabImages()
        setControllers()
        tabBar.tintColor = .white
    }
    
    private func setTabTitles() {
        vc1.tabBarItem.title = "Home"
        vc2.tabBarItem.title = "Search"
        vc3.tabBarItem.title = "Library"
        vc4.tabBarItem.title = "Profile"
    }
    
    private func setTabImages() {
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.tabBarItem.image = UIImage(systemName: "music.note.list")
        vc4.tabBarItem.image = UIImage(systemName: "person.circle")
    }
    
    private func setControllers() {
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }
}
