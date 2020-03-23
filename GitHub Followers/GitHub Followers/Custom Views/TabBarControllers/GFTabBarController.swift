//
//  GFTabBarController.swift
//  GitHub Followers
//
//  Created by Ramy Atalla on 2020-03-22.
//  Copyright © 2020 Ramy Atalla. All rights reserved.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers                 = [creatSearchNV(), creatFavoritesNV()]
   
    }
    
    
    func creatSearchNV() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let searchNC = UINavigationController(rootViewController: searchVC)
        return searchNC
    }
    
    
    func creatFavoritesNV() -> UINavigationController {
        let favoritesVC = FavoritesListVC()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites , tag: 1)
        let favoritesNC = UINavigationController(rootViewController: favoritesVC)
        return favoritesNC
    }

}
