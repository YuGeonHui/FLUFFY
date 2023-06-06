//
//  BaseViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupNavViews()
        setupBackButton()
        
        navigationController?.navigationBar.tintColor = UIColor(hex: "454545")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
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
    
    private func setupBackButton() {
        
        let attributes = [NSAttributedString.Key.font: UIFont.pretendard(.bold, size: 20),
                          NSAttributedString.Key.foregroundColor: UIColor(hex: "2d2d2d"),
                          NSAttributedString.Key.baselineOffset: -3] as [NSAttributedString.Key : Any]
     
//        let backButtonItem = UIBarButtonItem(title: "마이페이지", style: .plain, target: nil, action: nil)
        
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationItem.backBarButtonItem = backButtonItem

        navigationItem.backBarButtonItem?.setTitleTextAttributes(attributes, for: .normal)
    }
    
    @objc private func showMyPageVC() {
        
        self.tabBarController?.tabBar.isHidden = true
        
        let myPageVC = MyPageViewController()
//        let myPageVC = PageViewController()
        self.navigationController?.pushViewController(myPageVC, animated: true)
    }
}
