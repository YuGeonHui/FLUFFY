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

class MyPageViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    private enum Metric {
        
        static let spacing: CGFloat = 20
        
        static let nicknameAfter: CGFloat = 4
        
        static let statusBarSize: CGSize = CGSize(width: 65, height: 31)
        
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
            $0.font = UIFont.pretendard(.regular, size: 15)
        }
    }
    
    private let nicknameLabel = UILabel().then {
        $0.attributedText = "둥둥".set(style: Styles.nickname)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let editImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "pencil")
        $0.contentMode = .scaleAspectFit
    }
    
    private let statusBarImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "GoodStatus")
        $0.contentMode = .scaleAspectFit
    }
    
    private let messageLabel = UILabel().then {
        $0.attributedText = "스트레스가 쌓여 예민하고 지친상태".set(style: Styles.desc)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let characterImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "ProfileGood")
    }
    
    private let dividerView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor(hex: "b1b1b1")
    }
    
    private let pushSettingView = MyPageRowView(title: "푸시 알림 시간 설정 변경")
    
    private let noticeView = MyPageRowView(title: "공지사항")
    
    private let inquireView = MyPageRowView(title: "문의하기")
    
    private let termView = MyPageRowView(title: "이용약관")
    
    private lazy var stackView = UIStackView(arrangedSubviews: [pushSettingView, noticeView, inquireView, termView])
    
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
    
    private func setupViews() {
        
        self.stackView.axis = .vertical
        self.stackView.spacing = 20
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
    
        self.view.addSubview(nicknameLabel)
        self.view.addSubview(editImageView)
        self.view.addSubview(statusBarImageView)
        self.view.addSubview(messageLabel)
        self.view.addSubview(characterImageView)
        self.view.addSubview(dividerView)
        
        self.view.addSubview(stackView)
//        self.view
    }
    
    private func setupAutoLayout() {
        
        nicknameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        nicknameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        editImageView.leadingAnchor.constraint(equalTo: self.nicknameLabel.trailingAnchor, constant: 4).isActive = true
        editImageView.topAnchor.constraint(equalTo: self.nicknameLabel.topAnchor, constant: 5).isActive = true
        editImageView.widthAnchor.constraint(equalToConstant: Metric.iconSize.width).isActive = true
        editImageView.heightAnchor.constraint(equalToConstant: Metric.iconSize.height).isActive = true
        
        statusBarImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        statusBarImageView.topAnchor.constraint(equalTo: self.nicknameLabel.bottomAnchor, constant: 16).isActive = true
        
        messageLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        messageLabel.topAnchor.constraint(equalTo: self.statusBarImageView.bottomAnchor, constant: 16).isActive = true
        
        characterImageView.widthAnchor.constraint(equalToConstant: Metric.characterSize.width).isActive = true
        characterImageView.heightAnchor.constraint(equalToConstant: Metric.characterSize.height).isActive = true
        characterImageView.topAnchor.constraint(equalTo: self.nicknameLabel.topAnchor).isActive = true
        characterImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        
        NSLayoutConstraint.activate([
            dividerView.widthAnchor.constraint(equalToConstant: Metric.dividerSize.width),
            dividerView.heightAnchor.constraint(equalToConstant: Metric.dividerSize.height),
            dividerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            dividerView.topAnchor.constraint(equalTo: self.characterImageView.bottomAnchor, constant: 31),
//            dividerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
//            dividerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
//            dividerView.topAnchor.constraint(equalTo: self.characterImageView.bottomAnchor, constant: 31),
            
            stackView.topAnchor.constraint(equalTo: self.dividerView.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
    }
    
    private func bindInputs() {
        
        
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
            .bind(onNext: { $0.0.showMyInfoView() })
            .disposed(by: self.disposeBag)
        
    }
    
    deinit {
        viewModel.unbind()
    }
}

extension MyPageViewController {
    
    private func updateViews(_ status: Status?) {
        
        guard let status = status else { return }
        
        self.characterImageView.image = status.icon
        self.messageLabel.text = status.message
        self.statusBarImageView.image = status.statusBar
    }
    
    private func showMyInfoView() {
        
        let myInfoVC = MyInfoViewController()
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
}
