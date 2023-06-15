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

typealias FluffyHomeViewController = FluffyHomeView.ViewController
fileprivate typealias _Str = String.Home
extension FluffyHomeView {
    
    final class ViewController: BaseViewController {
        
        // MARK: Sub Views
        private let scrollView = UIScrollView()
        private let titleLabel = UILabel()
        private let descLabel = UILabel()
        private lazy var imageView = UIImageView()
        private let tagView = PaddingLabel()
        private let stateLabel = UILabel()
        
        // MARK: ViewModels
        private let viewModel = ViewModel()
        
        // MARK: Life Cycles
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.viewModel.bind()
            
            self.view.backgroundColor = Color.background
            
            self.setupViews()
            self.configereUI()
            self.bindView()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            guard KeychainService.shared.isTokenValidate() else {
                
                self.configereUI()
                self.noLoginAutoLayout()
                
                return
            }
            
            self.loginAutoLayout()
            self.viewModel.fetchInfo()
        }
        
        deinit {
            self.viewModel.unbind()
        }
        
        // MARK: Methods
        private func setupViews() {
            
            self.scrollView.translatesAutoresizingMaskIntoConstraints = false
            self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
            self.descLabel.translatesAutoresizingMaskIntoConstraints = false
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            self.tagView.translatesAutoresizingMaskIntoConstraints = false
            self.stateLabel.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(scrollView)
            self.view.addSubview(titleLabel)
            self.view.addSubview(descLabel)
            self.view.addSubview(imageView)
            self.view.addSubview(tagView)
            self.view.addSubview(stateLabel)
        }
        
        // 기본 셋팅은 로그인 이전으로 셋팅할 예정
        private func configereUI() {
            
            self.titleLabel.attributedText = _Str.title.set(style: Styles.title)
            self.descLabel.attributedText = _Str.desc.set(style: Styles.desc)
            self.descLabel.numberOfLines = 0
            self.imageView.contentMode = .scaleAspectFit
            self.imageView.image = UIImage(named: "character_login")
            
            self.tagView.attributedText = _Str.login.set(style: Styles.logIn)
            self.tagView.padding = Metric.loginInset
            self.tagView.backgroundColor = Color.loginTag
            
            self.stateLabel.attributedText = _Str.loginDesc.set(style: Styles.logInDesc)
        }
        
        private func noLoginAutoLayout() {
            
            NSLayoutConstraint.activate([
                
                self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Metric.topAnchor),
                
                self.descLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.descLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: Metric.NoLogin.titleAfter),
               
                self.imageView.topAnchor.constraint(equalTo: self.descLabel.bottomAnchor, constant: Metric.NoLogin.descAfter),
                self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                
                self.tagView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.tagView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: Metric.NoLogin.imageAfter),
                self.stateLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.stateLabel.topAnchor.constraint(equalTo: self.tagView.bottomAnchor, constant: Metric.NoLogin.tagAfter),
            ])
        }
        
        private func loginAutoLayout() {
            
            NSLayoutConstraint.activate([
            
                self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Metric.topAnchor),

                self.tagView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.tagView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: Metric.Login.titleAfter),

                self.stateLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.stateLabel.topAnchor.constraint(equalTo: self.tagView.bottomAnchor, constant: Metric.Login.tagAfter),
                
                self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                
                self.descLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.descLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: Metric.Login.bottomAnchor)
            ])
        }
        
        private func bindView() {
            
            self.viewModel.valueChanged
                .observe(on: MainScheduler.instance)
                .withUnretained(self)
                .bind(onNext: { $0.updateViews($1) })
                .disposed(by: self.disposeBag)
            
            self.tagView.rx.tapGesture()
                .when(.recognized)
                .filter { _ in !KeychainService.shared.isTokenValidate() }
                .withUnretained(self)
                .bind(onNext: {
                    $0.0.tabBarController?.tabBar.isHidden = true
                    
                    $0.0.navigationController?.pushViewController(SignUpViewController(), animated: true)
                })
                .disposed(by: self.disposeBag)
        }
        
        private func updateViews(_ viewValue: ViewValue?) {
            
            guard let viewValue else { return }
            
            self.stateLabel.text = viewValue.status.desc
            self.stateLabel.textColor = viewValue.status.background
            
            self.tagView.text = viewValue.status.localizable
            self.tagView.backgroundColor = viewValue.status.background
            
            self.imageView.image = viewValue.status.character
            
            self.descLabel.text = viewValue.status.message
            
            let nickname = UserDefaults.standard.string(forKey: NICKNAME_KEY)
            
            guard let nickname = nickname else { return }
            self.titleLabel.attributedText = nickname.set(style: Styles.title)
        }
    }
}
