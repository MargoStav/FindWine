//
//  FWTabBarController.swift
//  FindWine
//
//  Created by Маргарита Ставнийчук on 26.08.2022.
//

import UIKit

class FWTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = .systemRed
        viewControllers = [createSearchNavigationController(), createFavoritesNavigationController()]
    }
    
    func createSearchNavigationController() -> UINavigationController {
        let searchViewController = SearchVC()
        searchViewController.title = "Search"
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchViewController)
    }
   
    func createFavoritesNavigationController() -> UINavigationController {
        let favoritesViewController = FavoritesListVC()
        favoritesViewController.title = "Favorites"
        favoritesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoritesViewController)
    }

}
