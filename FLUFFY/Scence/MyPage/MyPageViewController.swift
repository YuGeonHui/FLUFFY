//
//  MyPageViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import Foundation
import RxSwift
import RxCocoa
import Then
import SwiftRichString

typealias FluffyMyPageViewController = FluffyMyPageView.ViewController
fileprivate typealias _Str = String.MyPage
extension FluffyMyPageView {
    
    final class ViewController: UIViewController {
        
        // MARK: SubVies
        private let titleLabel = UILabel()
        private let tagView = PaddingLabel()
        private let descLabel = UILabel()
        private let imageView = UIImageView()
        private let iconView = UIImageView()
        private let dividerView = DividerView()
        
        private let pushSettingView = MyPageRowView(title: _Str.PushSetting.title)
        private let noticeView = MyPageRowView(title: _Str.Notice.title)
        private let inquireView = MyPageRowView(title: _Str.Inquire.title)
        private let termView = MyPageRowView(title: _Str.Term.title)
        private let versionView = MyPageRowView(title: _Str.Version.title)
        
        // MARK: ViewModel
        private let viewModel = ViewModel()
        
        var disposeBag = DisposeBag()
        
        // MARK: Life Cycles
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.viewModel.bind()
            self.view.backgroundColor = Color.background
            
            self.setupView()
            self.configureUI()
            self.setupAutoLayout()
            self.setupRowAutoLayout()
            
            self.bindInputs()
            self.bindOutputs()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            guard KeychainService.shared.isTokenValidate() else {
                
                self.configureUI()
                return
            }
            
            self.viewModel.fetchInfo()
        }
        
        private func setupView() {
            
            self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
            self.tagView.translatesAutoresizingMaskIntoConstraints = false
            self.descLabel.translatesAutoresizingMaskIntoConstraints = false
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            self.iconView.translatesAutoresizingMaskIntoConstraints = false
            self.dividerView.translatesAutoresizingMaskIntoConstraints = false
            
            self.pushSettingView.translatesAutoresizingMaskIntoConstraints = false
            self.inquireView.translatesAutoresizingMaskIntoConstraints = false
            self.noticeView.translatesAutoresizingMaskIntoConstraints = false
            self.termView.translatesAutoresizingMaskIntoConstraints = false
            self.versionView.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(titleLabel)
            self.view.addSubview(tagView)
            self.view.addSubview(descLabel)
            self.view.addSubview(imageView)
            self.view.addSubview(iconView)
            self.view.addSubview(dividerView)
            
            self.view.addSubview(pushSettingView)
            self.view.addSubview(inquireView)
            self.view.addSubview(noticeView)
            self.view.addSubview(termView)
            self.view.addSubview(versionView)
        }
        
        // 기본 셋팅은 로그인 이전으로 셋팅
        private func configureUI() {
            
            self.titleLabel.attributedText = _Str.title.set(style: Styles.title)
            
            self.descLabel.attributedText = _Str.loginDesc.set(style: Styles.loginDesc)
            
            self.iconView.image = UIImage(named: "pencil")
            self.iconView.contentMode = .scaleAspectFit
            self.iconView.isHidden = !KeychainService.shared.isTokenValidate()
            
            self.imageView.image = UIImage(named: "goodIcon")
            self.imageView.contentMode = .scaleAspectFit
            
            self.tagView.backgroundColor = Color.loginTag
            self.tagView.padding = Metric.loginInset
            self.tagView.attributedText = _Str.login.set(style: Styles.status)
        }
        
        private func setupAutoLayout() {
            
            NSLayoutConstraint.activate([
            
                self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Metric.leadingAnchor),
                self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Metric.topAnchor),
                
                self.iconView.widthAnchor.constraint(equalToConstant: Metric.iconSize.width),
                self.iconView.heightAnchor.constraint(equalToConstant: Metric.iconSize.height),
                self.iconView.topAnchor.constraint(equalTo: self.titleLabel.topAnchor, constant: Metric.iconTopAnchor),
                self.iconView.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: Metric.iconBefore),
                
                self.tagView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Metric.leadingAnchor),
                self.tagView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: Metric.titleAfter),
                
                self.descLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Metric.leadingAnchor),
                self.descLabel.topAnchor.constraint(equalTo: self.tagView.bottomAnchor, constant: Metric.tagAfter),

                self.dividerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Metric.leadingAnchor),
                self.dividerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: Metric.trailingAnchor),
                self.dividerView.topAnchor.constraint(equalTo: self.descLabel.bottomAnchor, constant: Metric.descAfter),

                self.imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Metric.topAnchor),
                self.imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: Metric.trailingAnchor),
            ])
        }
        
        private func setupRowAutoLayout() {
            
            NSLayoutConstraint.activate([
            
                self.pushSettingView.topAnchor.constraint(equalTo: self.dividerView.bottomAnchor, constant: Metric.dividerAfter),
                self.pushSettingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.pushSettingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                
                self.inquireView.topAnchor.constraint(equalTo: self.pushSettingView.bottomAnchor, constant: Metric.stackSpacing),
                self.inquireView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.inquireView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                
                self.noticeView.topAnchor.constraint(equalTo: self.inquireView.bottomAnchor, constant: Metric.stackSpacing),
                self.noticeView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.noticeView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                
                self.termView.topAnchor.constraint(equalTo: self.noticeView.bottomAnchor, constant: Metric.stackSpacing),
                self.termView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.termView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                
                self.versionView.topAnchor.constraint(equalTo: self.termView.bottomAnchor, constant: Metric.stackSpacing),
                self.versionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.versionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            ])
        }
        
        private func bindInputs() {
            
            let nickTapped = self.titleLabel.rx.tapGesture()
                .when(.recognized)
            
            let editTapped = self.iconView.rx.tapGesture()
                .when(.recognized)
            
            Observable.of(nickTapped, editTapped).merge()
                .filter { _ in KeychainService.shared.isTokenValidate() }
                .withUnretained(self)
                .bind(onNext: { $0.0.viewModel.tapMyInfo() })
                .disposed(by: self.disposeBag)
            
            self.pushSettingView.buttonTapped
                .withUnretained(self)
                .bind(onNext: { $0.0.viewModel.tapPushSetting() })
                .disposed(by: self.disposeBag)
            
            self.noticeView.buttonTapped
                .withUnretained(self)
                .bind(onNext: { $0.0.viewModel.tapNotice() })
                .disposed(by: self.disposeBag)
            
            self.inquireView.buttonTapped
                .withUnretained(self)
                .bind(onNext: { $0.0.viewModel.tapInquire() })
                .disposed(by: self.disposeBag)
            
            self.termView.buttonTapped
                .withUnretained(self)
                .bind(onNext: { $0.0.viewModel.tapTerm() })
                .disposed(by: self.disposeBag)
        }
        
        private func bindOutputs() {
        
            self.viewModel.valueChanged
                .observe(on: MainScheduler.instance)
                .withUnretained(self)
                .bind(onNext: { $0.updateViews($1) })
                .disposed(by: self.disposeBag)
            
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
                .bind(onNext: { $0.0.showInquireView() })
                .disposed(by: self.disposeBag)
            
            self.viewModel.showTermView
                .withUnretained(self)
                .observe(on: MainScheduler.instance)
                .bind(onNext: { $0.0.showTermView() })
                .disposed(by: self.disposeBag)
        }
        
        private func updateViews(_ status: Status?) {
            
            guard let status = status else { return }
            
            let nickname = UserDefaults.standard.string(forKey: NICKNAME_KEY)
            
            guard let nickname = nickname else { return }
            self.titleLabel.attributedText = nickname.set(style: Styles.title)
            
            self.imageView.image = status.icon
            
            self.descLabel.text = status.desc
            self.descLabel.textColor = status.background
            
            self.tagView.text = status.localizable
            self.tagView.backgroundColor = status.background
            self.tagView.padding = Metric.loginInset
            
            self.view.setNeedsLayout()
        }
        
        deinit {
            viewModel.unbind()
        }
    }
}

// MARK: Methods
extension FluffyMyPageViewController {
    
    private func showMyInfoView() {
        
        let myInfoVC = NicknameChangeViewController()
        self.navigationController?.pushViewController(myInfoVC, animated: true)
    }
    
    private func showPushSettingView() {
        
        let pushSettingVC = PushSettingViewController()
        self.navigationController?.pushViewController(pushSettingVC, animated: true)
    }
    
    private func showNoticeView() {
        Opener.open(urlString: Web.instagram)
    }
    
    private func showInquireView() {
        Opener.open(urlString: Web.googleForm)
    }
    
    private func showTermView() {
        Opener.open(urlString: Web.term)
    }
}
