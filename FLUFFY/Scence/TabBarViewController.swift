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
        
        UINavigationBar.appearance().prefersLargeTitles = true
    }
    
    private func setupViews() {
        
        let homeVC = generateNavController(vc: ViewController(), title: "홈", image: UIImage(systemName: "house"))
        let schedulerVC = generateNavController(vc: ScheudlerViewController(), title: "스케줄링", image: UIImage(systemName: "calendar"))
        let myPageVC = generateNavController(vc: MyPageViewController(), title: "마이페이지", image: UIImage(systemName: "person.crop.circle"))
        
        self.viewControllers = [homeVC, schedulerVC, myPageVC]
        
        self.selectedIndex = 0
    }
    
    fileprivate func generateNavController(vc: UIViewController, title: String, image: UIImage?) -> UINavigationController {
        
        navigationItem.title = title
        
        let navController = UINavigationController(rootViewController: vc)
        navController.title = title
        navController.tabBarItem.image = image
        
        return navController
    }
}
