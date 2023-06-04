//
//  SignUpViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import AuthenticationServices
import SwiftRichString

final class SignUpViewController: UIViewController {
    
    private enum Metric {
        
        static let stackSpacing: CGFloat = 18
        
        static let sigInLogoSize: CGSize = CGSize(width: 268, height: 54)
        
    }
    
    private enum Styles {
        
        static let title: Style = Style {
            $0.font = UIFont.pretendard(.bold, size: 25)
            $0.color = UIColor(hex: "2d2d2d")
        }
        
        static let desc: Style = Style {
            $0.font = UIFont.pretendard(.medium, size: 15)
            $0.color = UIColor(hex: "656565")
        }
    }
    
    private let logoImgView = UIImageView()

    private let titleLabel = UILabel()

    private let descLabel = UILabel()
    
    private lazy var titleStackView = UIStackView(arrangedSubviews: [logoImgView, titleLabel, descLabel])
    
    private let backImageView = UIImageView()
    
    private let signUpButton = ASAuthorizationAppleIDButton(type: .signIn, style: .black)


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: "f9f9f9")
        
        self.setupViews()
        self.setupAutoLayout()
    }
    
    private func setupViews() {
        
        self.titleStackView.translatesAutoresizingMaskIntoConstraints = false
        self.backImageView.translatesAutoresizingMaskIntoConstraints = false
        self.signUpButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(titleStackView)
        self.view.addSubview(backImageView)
        self.view.addSubview(signUpButton)
        
        self.logoImgView.image = UIImage(named: "fluffy_logo")
        self.logoImgView.contentMode = .scaleAspectFit
        
        self.titleLabel.attributedText = "로그인".set(style: Styles.title)
        
        self.descLabel.attributedText = "플러피와 함께 슬기로운 일정관리 시작!".set(style: Styles.desc)
        
        self.titleStackView.axis = .vertical
        self.titleStackView.alignment = .leading
        self.titleStackView.spacing = Metric.stackSpacing
        
        self.backImageView.image = UIImage(named: "background")
//        self.backImageView.contentMode = .scaleAspectFit
    }
    
    private func setupAutoLayout() {
        
        NSLayoutConstraint.activate([
            
            self.titleStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.titleStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.titleStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 56),
            
            self.backImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0),
            self.backImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0),
            self.backImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
//            self.signUpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.signUpButton.topAnchor.constraint(equalTo: self.backImageView.topAnchor, constant: 200),
            self.signUpButton.widthAnchor.constraint(equalToConstant: Metric.sigInLogoSize.width),
            self.signUpButton.widthAnchor.constraint(equalToConstant: Metric.sigInLogoSize.height),
        ])
    }
}
