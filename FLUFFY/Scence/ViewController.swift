//
//  ViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/25.
//

import UIKit
import AuthenticationServices

final class ViewController: UIViewController {
    
    private let signInView = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        self.view.addSubview(signInView)
        
        signInView.translatesAutoresizingMaskIntoConstraints = false
        signInView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        signInView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
}

extension ViewController: ASAuthorizationControllerDelegate {
    
    
}


