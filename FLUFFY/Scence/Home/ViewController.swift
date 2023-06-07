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
        
        static let statusBar: Style = Style {
            $0.font = UIFont.candyBean(.normal, size: 19)
            $0.color = UIColor(hex: "ffffff")
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
    private let nicknameLabel = UILabel()
    
    private let statusLabel = PaddingLabel().then {
        $0.backgroundColor = UIColor(hex: "19c8ff")
        $0.attributedText = "Good".set(style: Styles.statusBar)
        $0.padding = UIEdgeInsets(top: 11, left: 8, bottom: 9, right: 12)
    }
    
    private let statusDesc = UILabel().then {
        $0.attributedText = "적절한 스트레스가 도움이 되는 상태".set(style: Styles.status)
    }
    
    private let characterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "character_good")
    }
    
    private let messageLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.attributedText = "스트레스 관리를 잘 하고 계시네요 !\n현재 상태를 유지하도록 꾸준히 노력해봐요.".set(style: Styles.message)
    }
    
    private lazy var topStackView = UIStackView(arrangedSubviews: [nicknameLabel, statusLabel, statusDesc])
    
    // MARK: ViewModel
    private let viewModel = HomeViewModel()
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupAutoLayout()
        bindInputs()
        bindOutputs()
      
        viewModel.bind()
        
        self.view.backgroundColor = UIColor(hex: "f9f9f9")
        
        self.bindInputs()
        self.bindOutputs()
        
        self.viewModel.fetchInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let nickname = UserDefaults.standard.string(forKey: NICKNAME_KEY)
        
        guard let nickname = nickname else { return }
        self.nicknameLabel.attributedText = nickname.set(style: Styles.nickname)
    }
    
    deinit {
        viewModel.unbind()
    }
    
    private func setupViews() {
        
        self.view.addSubview(topStackView)
        self.view.addSubview(characterImageView)
        self.view.addSubview(messageLabel)
        
        self.topStackView.translatesAutoresizingMaskIntoConstraints = false
        self.characterImageView.translatesAutoresizingMaskIntoConstraints = false
        self.messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        topStackView.axis = .vertical
        topStackView.alignment = .center
        topStackView.spacing = 20
    }
    
    private func setupAutoLayout() {
        
        NSLayoutConstraint.activate([
            
            self.topStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.topStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.topStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),

            self.characterImageView.topAnchor.constraint(equalTo: self.topStackView.bottomAnchor, constant: 20),
            self.characterImageView.bottomAnchor.constraint(equalTo: self.messageLabel.topAnchor, constant: -20),
            self.characterImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.messageLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.messageLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.messageLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -80)
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
        
        self.characterImageView.image = status.icon
        self.messageLabel.text = status.message
    }
}

extension ViewController {
    
    
}
