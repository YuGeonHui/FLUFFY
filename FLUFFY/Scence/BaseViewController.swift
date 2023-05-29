//
//  BaseViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavViews()
    }
    
    private func setupNavViews() {
    
        self.view.backgroundColor = .white
        
        let leftImage = UIImage(named: "fluffy_logo")
        let rightImage = UIImage(named: "icon_user")
        
        let leftButtonItem = UIBarButtonItem(image: leftImage, style: .plain, target: self, action: nil)
        let rightButtonItem = UIBarButtonItem(image: rightImage, style: .plain, target: self, action: #selector(showMyPageVC))
        
        navigationItem.leftBarButtonItem = leftButtonItem
        navigationItem.leftBarButtonItem?.tintColor = UIColor(hex: "191919")
        navigationItem.rightBarButtonItem = rightButtonItem
        navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: "454545")
    }
    
    @objc private func showMyPageVC() {
        
        let myPageVC = MyPageViewController()
        self.navigationController?.pushViewController(myPageVC, animated: true)
    }
}
