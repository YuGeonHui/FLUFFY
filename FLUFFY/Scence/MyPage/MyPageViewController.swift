//
//  MyPageViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import Foundation
import RxSwift
import RxCocoa

class MyPageViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    private enum Metric {
        
        static let spacing: CGFloat = 20
        
        static let nicknameAfter: CGFloat = 4
        static let imgeSize: CGSize = CGSize(width: 85, height: 85)
//        static let 
    }
    
    private let nicknameLabel = UILabel().then {
        $0.text = "동동"
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let editImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var userStackView = UIStackView(arrangedSubviews: [nicknameLabel, editImageView]).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let statusBarImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let messageLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var userInfoStackView = UIStackView(arrangedSubviews: [userStackView, statusBarImageView, messageLabel]).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let characterImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var stackView = UIStackView(arrangedSubviews: [userInfoStackView, characterImageView]).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let dividerView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let viewModel = MyPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
    
        self.setupViews()
        self.setupAutoLayout()
        
        self.bindInputs()
        self.bindOutputs()
        
        viewModel.bind()
    }
    
    private func setupViews() {
        
        self.view.addSubview(stackView)
    }
    
    private func setupAutoLayout() {
        
        stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Metric.spacing).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Metric.spacing).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: Metric.spacing).isActive = true
    }
    
    private func bindInputs() {
        
    }
    
    private func bindOutputs() {
        
        self.viewModel.showMyInfoView
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind(onNext: { $0.0.showMyInfoView() })
            .disposed(by: self.disposeBag)
        
        self.viewModel.showPushSettingView
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind(onNext: { $0.0.showPushSettingView() })
            .disposed(by: self.disposeBag)
        
        self.viewModel.showNoticeView
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind(onNext: { $0.0.showNoticeView() })
            .disposed(by: self.disposeBag)
        
        self.viewModel.showInquireView
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .bind(onNext: { $0.0.showMyInfoView() })
            .disposed(by: self.disposeBag)
        
    }
    
    deinit {
        viewModel.unbind()
    }
}

extension MyPageViewController {
    
    private func showMyInfoView() {
        
    }
    
    private func showPushSettingView() {
        
    }
    
    private func showNoticeView() {
        
        
    }
    
    private func showInquireView() {
        
        
    }
}
