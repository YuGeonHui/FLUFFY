//
//  HomeViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftRichString

final class HomeViewController: BaseViewController {

    private let titleLabel = UILabel()
    
    private let descLabel = UILabel()
    
    private let characterImageView = UIImageView()
    
    private let logInButton = PaddingLabel()
    
    private let logInDesc = UILabel()
    
    private enum Metric {
        
        static let logInInset: UIEdgeInsets = UIEdgeInsets(top: 3, left: 11, bottom: 3, right: 11)
    }
    
    private enum Styles {
        
        static let title: Style = Style {
            $0.font = UIFont.pretendard(.bold, size: 24)
            $0.color = UIColor(hex: "2c2c2c")
            $0.alignment = .center
        }
        
        static let desc: Style = Style {
            $0.font = UIFont.pretendard(.medium, size: 15)
            $0.color = UIColor(hex: "2d2d2d")
            $0.alignment = .center
            $0.minimumLineHeight = 26
            $0.maximumLineHeight = 26
        }
        
        static let logIn: Style = Style {
            $0.font = UIFont.candyBean(.normal, size: 19)
            $0.color = UIColor(hex: "ffffff")
            $0.alignment = .center
        }
        
        static let logInDesc: Style = Style {
            $0.font = UIFont.pretendard(.semiBold, size: 14)
            $0.color = UIColor(hex: "89bfff")
            $0.alignment = .center
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: "f9f9f9")
        
        self.setupViews()
        self.setupAutoLayout()
        self.bindView()
    }
    
    private func setupViews() {
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descLabel.translatesAutoresizingMaskIntoConstraints = false
        self.characterImageView.translatesAutoresizingMaskIntoConstraints = false
        self.logInButton.translatesAutoresizingMaskIntoConstraints = false
        self.logInDesc.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(descLabel)
        self.view.addSubview(characterImageView)
        self.view.addSubview(logInButton)
        self.view.addSubview(logInDesc)
        
        self.titleLabel.attributedText = "만나서 반가워요!".set(style: Styles.title)
        self.descLabel.attributedText = "당신만의 번아웃 예방 가이드, 플러피에요!\n저와 함께 슬기로운 일정관리를 시작해 볼까요?".set(style: Styles.desc)
        self.descLabel.numberOfLines = 0
        
        self.characterImageView.contentMode = .scaleAspectFit
        self.characterImageView.image = UIImage(named: "character_login")
        
        self.logInButton.attributedText = "Log in >".set(style: Styles.logIn)
        self.logInButton.padding = Metric.logInInset
        self.logInButton.font = UIFont.candyBean(.normal, size: 19)
        self.logInButton.backgroundColor = UIColor(hex: "89bfff")
        
        self.logInDesc.attributedText = "로그인하고 번아웃 예방하기".set(style: Styles.logInDesc)
    }
    
    private func setupAutoLayout() {
        
        NSLayoutConstraint.activate([
            
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 45),
            
            descLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            descLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 19),
            
            characterImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            characterImageView.topAnchor.constraint(equalTo: self.descLabel.bottomAnchor, constant: 42),
            
            logInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logInButton.topAnchor.constraint(equalTo: self.characterImageView.bottomAnchor, constant: 35),
            
            logInDesc.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logInDesc.topAnchor.constraint(equalTo: self.logInButton.bottomAnchor, constant: 12),
        ])
    }
    
    private func bindView() {
        
        self.logInButton.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind(onNext: {
                
                $0.0.tabBarController?.tabBar.isHidden = true
                
                $0.0.navigationController?.pushViewController(SignUpViewController(), animated: true)
            })
            .disposed(by: self.disposeBag)
    }
}
