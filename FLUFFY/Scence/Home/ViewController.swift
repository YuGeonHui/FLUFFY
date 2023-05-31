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

final class ViewController: BaseViewController {
    
    private enum Metric {
        static let iconSize: CGSize = CGSize(width: 300, height: 300)
        static let statusSpacing: CGFloat = 4
        
        static let stackSpacing: CGFloat = 11
        static let statusSize: CGSize = CGSize(width: 65, height: 31)
        
        static let infoSize: CGSize = CGSize(width: 20, height: 20)
    }
    
    // MARK: Views
    private let nicknameLabel = UILabel().then {
        $0.font = UIFont.pretendard(.bold, size: 24)
        $0.textAlignment = .center
        $0.textColor = UIColor(hex: "2c2c2c")
        $0.text = "둥둥"
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let characterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "GoodCharacter")
    }
    
    private let statusImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var stackView = UIStackView(arrangedSubviews: [nicknameLabel, characterImageView, messageLabel]).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = Metric.stackSpacing
    }
    
    private let messageLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "동동님의 상태가 좋지 않아요.\n회복을 위해 휴식을 취하시는 것을 추천드려요."
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
    
    deinit {
        viewModel.unbind()
    }
    
    private func setupAutoLayout() {
        
        self.view.addSubview(self.nicknameLabel)
        
        NSLayoutConstraint.activate([
            self.nicknameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 60),
            self.nicknameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
}

// MARK: Bindings
extension ViewController {
    
    private func bindInputs() {
        
    }
    
    private func bindOutputs() {
        
        self.viewModel.valueChanged
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { $0.0.updateViews($0.1) })
            .disposed(by: self.disposeBag)
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
