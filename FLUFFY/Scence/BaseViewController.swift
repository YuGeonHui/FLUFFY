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
        
        let attributes = [NSAttributedString.Key.font: UIFont.pretendard(.bold, size: 25),
                          NSAttributedString.Key.foregroundColor: UIColor(hex: "454545"),
                          NSAttributedString.Key.baselineOffset: -3] as [NSAttributedString.Key : Any]
     
        let backButtonItem = UIBarButtonItem(title: "마이페이지", style: .plain, target: nil, action: nil)
        
        navigationItem.backBarButtonItem = backButtonItem

        navigationItem.backBarButtonItem?.setTitleTextAttributes(attributes, for: .normal)
    }
    
    private func setupBackButton2() {
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        
        let backImage = UIImage(named: "icon_back")?.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0))
        backButton.setBackButtonBackgroundImage(backImage, for: .normal, barMetrics: .default)
    }
    
    @objc private func showMyPageVC() {
        
        self.tabBarController?.tabBar.isHidden = true
        
//        let myPageVC = MyPageViewController()
//        let myPageVC = AssociationViewController()
        let myPageVC = SignUpViewController()
        self.navigationController?.pushViewController(myPageVC, animated: true)
    }
}
