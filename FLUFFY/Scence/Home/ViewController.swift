//
//  ViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/25.
//

import UIKit
import AuthenticationServices
import RxGesture

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
    
    private let statusView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "GoodStatus")
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let infoView = UIButton().then {
        $0.setImage(UIImage(named: "info"), for: .normal)
        $0.imageView?.contentMode = .scaleToFill
    }
    
    private lazy var infoStackView = UIStackView(arrangedSubviews: [statusView, infoView]).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = Metric.statusSpacing
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
        
        // MARK: Binding
        viewModel.bind()
    }
    
    private func setupAutoLayout() {
        
        self.view.addSubview(self.nicknameLabel)
        self.view.addSubview(self.infoStackView)
        
        self.nicknameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        self.nicknameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.statusView.widthAnchor.constraint(equalToConstant: 65).isActive = true
        self.statusView.heightAnchor.constraint(equalToConstant: 31).isActive = true
        
        self.infoView.widthAnchor.constraint(equalToConstant: Metric.infoSize.width).isActive = true
        self.infoView.heightAnchor.constraint(equalToConstant: Metric.infoSize.height).isActive = true
        
        self.infoStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.infoStackView.topAnchor.constraint(equalTo: self.nicknameLabel.bottomAnchor, constant: 14).isActive = true
        

//        self.toolTipView.widthAnchor.constraint(equalToConstant: Metric.infoSize.width).isActive = true
//        self.toolTipView.heightAnchor.constraint(equalToConstant: Metric.infoSize.height).isActive = true
        
//        self.characterImageView.widthAnchor.constraint(equalToConstant: Metric.iconSize.width).isActive = true
//        self.statusView.widthAnchor.constraint(equalToConstant: Metric.statusSize.width).isActive = true
//
//        self.statusView.heightAnchor.constraint(equalToConstant: 31).isActive = true
        
//        self.characterImageView.heightAnchor.constraint(equalToConstant: Metric.iconSize.height).isActive = true
        
//        self.stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        self.stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    // MARK: 툴팁 화면 표출하기
    private func showTooTipView() {
        
        let toolTipVC = MyPageViewController()
        self.navigationController?.pushViewController(toolTipVC, animated: true)
    }
}

// MARK: Bindings
extension ViewController {
    
    private func bindInputs() {
        
        self.infoView.rx.tap
            .withUnretained(self)
            .bind(onNext: { $0.0.viewModel.tapToolTip() })
            .disposed(by: self.disposeBag)
    }
    
    private func bindOutputs() {
        
        self.viewModel.showToolTip
            .withUnretained(self)
            .bind(onNext: { $0.0.showTooTipView() })
            .disposed(by: self.disposeBag)
    }
}
