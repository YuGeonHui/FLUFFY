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

class MyPageViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    private enum Metric {
        
        static let spacing: CGFloat = 20
        
        static let nicknameAfter: CGFloat = 4
        
        static let iconSize: CGSize = CGSize(width: 21, height: 21)
        static let imgeSize: CGSize = CGSize(width: 85, height: 85)
    }
    
    private let nicknameLabel = UILabel().then {
        $0.text = "동동"
        $0.font = UIFont.pretendard(.bold, size: 25)
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
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let characterImageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
//    private lazy var stackView = UIStackView(arrangedSubviews: [userInfoStackView, characterImageView]).then {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//    }
    
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
    
        self.view.addSubview(nicknameLabel)
        self.view.addSubview(editImageView)
        self.view.addSubview(statusBarImageView)
        self.view.addSubview(messageLabel)
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
    }
    
    private func bindInputs() {
        
//        self.editImageView
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
