//
//  ViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/25.
//

import UIKit
import AuthenticationServices
import RxSwift
import RxCocoa
import SwiftRichString

final class ViewController: BaseViewController {
    
    private enum Metric {
        
        static let leadingInset: CGFloat = 20
        
        static let trailingInset: CGFloat = 20
        
        static let statusBarSize: CGSize = CGSize(width: 65, height: 31)
        
        static let charaterSize: CGSize = CGSize(width: 300, height: 300)
        
        static let nickBefore: CGFloat = 60
        
        static let nickAfter: CGFloat = 11
        
        static let statusAfter: CGFloat = 11
        
        static let characterAfter: CGFloat = 11
    }
    
    private enum Styles {
        
        static var nickname: Style = Style {
            $0.font = UIFont.pretendard(.bold, size: 24)
            $0.color = UIColor(hex: "2c2c2c")
            $0.alignment = .center
        }
        
        static let message: Style = Style {
            $0.font = UIFont.pretendard(.medium, size: 15)
            $0.color = UIColor(hex: "2d2d2d")
            $0.minimumLineHeight = 26
            $0.maximumLineHeight = 26
            $0.alignment = .center
        }
        
        static let status: Style = Style {
            $0.font = UIFont.pretendard(.semiBold, size: 14)
            $0.color = UIColor(hex: "19c8ff")
            $0.alignment = .center
        }
    }
    
    // MARK: Views
    private let nicknameLabel = UILabel().then {
        $0.attributedText = "둥둥".set(style: Styles.nickname)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let statusImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "GoodStatus")
    }
    
    private let statusDesc = UILabel().then {
        $0.attributedText = "적절한 스트레스가 도움이 되는 상태".set(style: Styles.status)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let characterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "character_warning")
    }
    
    private let messageLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedText = "일과 휴식의 경계가 아슬아슬해요!\n적절한 휴식시기를 놓치지 않도록 주의해주세요.".set(style: Styles.message)
    }
    
    // MARK: ViewModel
    private let viewModel = HomeViewModel()
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAutoLayout()
        bindInputs()
        bindOutputs()
        
        viewModel.bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
//            self.characterImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
//        }, completion: { _ in
//            UIView.animate(withDuration: 0.5) {
//                self.characterImageView.transform = CGAffineTransform.identity
//            }
//        })
        
                let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
                shakeAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
                shakeAnimation.duration = 0.5
                shakeAnimation.values = [-10, 10, -8, 8, -6, 6, -4, 4, -2, 2, 0]
                characterImageView.layer.add(shakeAnimation, forKey: "shakeAnimation")
    }
    
    deinit {
        viewModel.unbind()
    }
    
    private func setupAutoLayout() {
        
        self.view.addSubview(self.nicknameLabel)
        self.view.addSubview(self.statusImageView)
        self.view.addSubview(self.statusDesc)
        self.view.addSubview(self.characterImageView)
        self.view.addSubview(self.messageLabel)
        
        NSLayoutConstraint.activate([
            self.nicknameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Metric.nickBefore),
            self.nicknameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.statusImageView.topAnchor.constraint(equalTo: self.nicknameLabel.bottomAnchor, constant: 11),
            self.statusImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.statusImageView.widthAnchor.constraint(equalToConstant: Metric.statusBarSize.width),
            self.statusImageView.heightAnchor.constraint(equalToConstant: Metric.statusBarSize.height),
            
            self.statusDesc.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.statusDesc.topAnchor.constraint(equalTo: self.statusImageView.bottomAnchor, constant: 11),
            
            self.characterImageView.topAnchor.constraint(equalTo: self.statusDesc.bottomAnchor, constant: 11),
            self.characterImageView.widthAnchor.constraint(equalToConstant: Metric.charaterSize.width),
            self.characterImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.characterImageView.heightAnchor.constraint(equalToConstant: Metric.charaterSize.height),
            
            self.messageLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.messageLabel.topAnchor.constraint(equalTo: self.characterImageView.bottomAnchor, constant: 33)
        ])
    }
}

// MARK: Bindings
extension ViewController {
    
    private func bindInputs() {
        
    }
    
    private func bindOutputs() {
        
//        self.viewModel.valueChanged
//            .observe(on: MainScheduler.instance)
//            .withUnretained(self)
//            .bind(onNext: { $0.0.updateViews($0.1) })
//            .disposed(by: self.disposeBag)
    }
}

extension ViewController {
    
    private func updateViews(_ status: Status?) {
        
        guard let status = status else { return }
        
        self.statusImageView.widthAnchor.constraint(equalToConstant: status.statusBarSize.width).isActive = true
        self.statusImageView.heightAnchor.constraint(equalToConstant: status.statusBarSize.height).isActive = true
        self.statusImageView.image = status.statusBar
        
        self.characterImageView.image = status.icon
        self.messageLabel.text = status.message
    }
}
