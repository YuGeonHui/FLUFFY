//
//  TabBarViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        
//        UINavigationBar.appearance().prefersLargeTitles = true
        
        UITabBar.appearance().tintColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }
    
    private func setupViews() {
        
        let homeTabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Home_duotone"), selectedImage: UIImage(named: "Home_fill"))
        let schedulerBartItem = UITabBarItem(title: "Schedule", image: UIImage(named: "Date_range"), selectedImage: UIImage(named: "Date_range_fill"))
        
        let homeVC = generateNavController(vc: ViewController(), tabBarItem: homeTabBarItem)
        let schedulerVC = generateNavController(vc: ScheudlerViewController(), tabBarItem: schedulerBartItem)
        
        self.viewControllers = [homeVC, schedulerVC]
        self.selectedIndex = 0
    }
    
    fileprivate func generateNavController(vc: UIViewController, tabBarItem: UITabBarItem) -> UINavigationController {
        
        navigationItem.title = title
        
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = tabBarItem
        
        return navController
    }
}
