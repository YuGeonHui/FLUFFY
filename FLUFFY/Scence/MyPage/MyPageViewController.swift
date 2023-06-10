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
//import RxGesture
import SwiftRichString

class MyPageViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    private enum Metric {
        
        static let spacing: CGFloat = 20
        
        static let nicknameAfter: CGFloat = 4
        
        static let statusBarSize: CGSize = CGSize(width: 50, height: 24)
        
        static let iconSize: CGSize = CGSize(width: 21, height: 21)
        
        static let characterSize: CGSize = CGSize(width: 85, height: 85)
        
        static let dividerSize: CGSize = CGSize(width: 350, height: 1)
    }
    
    private enum Styles {
        
        static let nickname: Style = Style {
            $0.font = UIFont.pretendard(.bold, size: 25)
            $0.color = UIColor(hex: "1f1f1f")
        }
        
        static let desc: Style = Style {
            $0.font = UIFont.pretendard(.semiBold, size: 14)
            $0.color = UIColor(hex: "89bfff")
        }
        
        static let status: Style = Style {
            $0.font = UIFont.candyBean(.normal, size: 15)
            $0.color = UIColor(hex: "ffffff")
        }
        
        static let goodDesc: Style = Style {
            $0.font = UIFont.pretendard(.semiBold, size: 14)
            $0.color = UIColor(hex: "19c8ff")
        }
    }
    
    private lazy var nicknameLabel = UILabel().then {
        $0.attributedText = "환영해요!".set(style: Styles.nickname)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let editImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "pencil")
        $0.contentMode = .scaleAspectFit
    }
    
    private var statusLabel = PaddingLabel().then {
        $0.padding = UIEdgeInsets(top: 5, left: 7.5, bottom: 5, right: 7.5)
        $0.backgroundColor = UIColor(hex: "89bfff")
        $0.attributedText = "Log in >".set(style: Styles.status)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let messageLabel = UILabel().then {
        $0.attributedText = "로그인하고 번아웃 예방하기".set(style: Styles.desc)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let characterImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "goodIcon")
    }
    
    private let dividerView = DividerView()
    
    private let pushSettingView = MyPageRowView(title: "푸시 알림 시간 설정 변경").then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let noticeView = MyPageRowView(title: "공지사항").then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let inquireView = MyPageRowView(title: "문의하기").then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let termView = MyPageRowView(title: "이용약관").then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let versionView = MyPageRowView(title: "버전정보", hasVersion: true).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let viewModel = MyPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(hex: "f9f9f9")
    
        self.setupViews()
        self.setupAutoLayout()
        
        self.bindInputs()
        self.bindOutputs()
        
        viewModel.bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateViews()
    }
    
    private func setupViews() {
    
        self.view.addSubview(nicknameLabel)
        self.view.addSubview(editImageView)
        
        self.view.addSubview(statusLabel)
        self.view.addSubview(messageLabel)
        self.view.addSubview(characterImageView)
        self.view.addSubview(dividerView)
        
        self.view.addSubview(pushSettingView)
        self.view.addSubview(noticeView)
        self.view.addSubview(inquireView)
        self.view.addSubview(termView)
        self.view.addSubview(versionView)
    }
    
    private func setupAutoLayout() {
        
        nicknameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        nicknameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        editImageView.leadingAnchor.constraint(equalTo: self.nicknameLabel.trailingAnchor, constant: 4).isActive = true
        editImageView.topAnchor.constraint(equalTo: self.nicknameLabel.topAnchor, constant: 5).isActive = true
        editImageView.widthAnchor.constraint(equalToConstant: Metric.iconSize.width).isActive = true
        editImageView.heightAnchor.constraint(equalToConstant: Metric.iconSize.height).isActive = true
        
        statusLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        statusLabel.topAnchor.constraint(equalTo: self.nicknameLabel.bottomAnchor, constant: 12).isActive = true
        
        messageLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        messageLabel.topAnchor.constraint(equalTo: self.statusLabel.bottomAnchor, constant: 12).isActive = true
        
        characterImageView.widthAnchor.constraint(equalToConstant: Metric.characterSize.width).isActive = true
        characterImageView.heightAnchor.constraint(equalToConstant: Metric.characterSize.height).isActive = true
        characterImageView.topAnchor.constraint(equalTo: self.nicknameLabel.topAnchor).isActive = true
        characterImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        NSLayoutConstraint.activate([
            dividerView.widthAnchor.constraint(equalToConstant: Metric.dividerSize.width),
            dividerView.heightAnchor.constraint(equalToConstant: Metric.dividerSize.height),
            dividerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            dividerView.topAnchor.constraint(equalTo: self.characterImageView.bottomAnchor, constant: 21),
            
            pushSettingView.topAnchor.constraint(equalTo: self.dividerView.bottomAnchor, constant: 30),
            pushSettingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            pushSettingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            noticeView.topAnchor.constraint(equalTo: self.pushSettingView.bottomAnchor, constant: 20),
            noticeView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            noticeView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            inquireView.topAnchor.constraint(equalTo: self.noticeView.bottomAnchor, constant: 20),
            inquireView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            inquireView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            termView.topAnchor.constraint(equalTo: self.inquireView.bottomAnchor, constant: 20),
            termView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            termView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            versionView.topAnchor.constraint(equalTo: self.termView.bottomAnchor, constant: 20),
            versionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            versionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    private func bindInputs() {
        
        let nickTapped = self.nicknameLabel.rx.tapGesture()
            .when(.recognized)
        
        let editTapped = self.editImageView.rx.tapGesture()
            .when(.recognized)
        
        Observable.of(nickTapped, editTapped).merge()
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
    
    private func updateViews() {
        
        guard let _ = KeychainService.shared.loadToken() else { return }
        
        let nickname = UserDefaults.standard.string(forKey: NICKNAME_KEY)
        
        guard let nickname = nickname else { return }
        self.nicknameLabel.attributedText = nickname.set(style: Styles.nickname)
        
        self.statusLabel.padding = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        self.statusLabel.backgroundColor = UIColor(hex: "19c8ff")
        self.statusLabel.attributedText = "GOOD".set(style: Styles.status)
        
        self.messageLabel.attributedText = "적절한 스트레스가 도움이 되는 상태".set(style: Styles.goodDesc)
    }
    
    deinit {
        viewModel.unbind()
    }
}

// MARK: Methods
extension MyPageViewController {
    
    private func updateViews(_ status: Status?) {
        
        guard let status = status else { return }
        
        self.characterImageView.image = status.character
        self.statusLabel.attributedText = status.desc.set(style: Styles.goodDesc)
        self.statusLabel.backgroundColor = status.background
        self.statusLabel.padding = UIEdgeInsets(top: 8, left: 11, bottom: 9, right: 11)
        
        self.view.setNeedsLayout()
    }
    
    private func showMyInfoView() {
        
//        let myInfoVC = MyInfoViewController()
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
