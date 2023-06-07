//
//  SignUpViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import UIKit
import Then
import RxSwift
import RxCocoa
import AuthenticationServices
import SwiftRichString

final class SignUpViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private enum Metric {
        
        static let stackSpacing: CGFloat = 18
        
        static let sigInLogoSize: CGSize = CGSize(width: 268, height: 54)
    }
    
    private enum Styles {
        
        static let title: Style = Style {
            $0.font = UIFont.pretendard(.bold, size: 25)
            $0.color = UIColor(hex: "2d2d2d")
        }
        
        static let desc: Style = Style {
            $0.font = UIFont.pretendard(.medium, size: 15)
            $0.color = UIColor(hex: "656565")
        }
    }
    
    private let logoImgView = UIImageView()
    
    private let titleLabel = UILabel()
    
    private let descLabel = UILabel()
    
    private lazy var titleStackView = UIStackView(arrangedSubviews: [logoImgView, titleLabel, descLabel])
    
    private let backImageView = UIImageView()
    
    private let appleSignIn = UIImageView()
    
    private let signUpButton = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    
    private let signInFinished = PublishRelay<Void>()
    
    private let viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: "f9f9f9")
        
        self.setupViews()
        self.setupAutoLayout()
        self.bindView()
        
        self.viewModel.bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = UIColor(hex: "454545")
        self.navigationItem.backBarButtonItem?.title = ""
    }
    
    deinit {
        viewModel.unbind()
    }
    
    private func setupViews() {
        
        self.titleStackView.translatesAutoresizingMaskIntoConstraints = false
        self.backImageView.translatesAutoresizingMaskIntoConstraints = false
        self.appleSignIn.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(titleStackView)
        self.view.addSubview(backImageView)
        self.view.addSubview(appleSignIn)
        
        self.logoImgView.image = UIImage(named: "fluffy_logo")
        self.logoImgView.contentMode = .scaleAspectFit
        
        self.titleLabel.attributedText = "로그인".set(style: Styles.title)
        
        self.descLabel.attributedText = "플러피와 함께 슬기로운 일정관리 시작!".set(style: Styles.desc)
        
        self.titleStackView.axis = .vertical
        self.titleStackView.alignment = .leading
        self.titleStackView.spacing = Metric.stackSpacing
        
        self.backImageView.image = UIImage(named: "background")
        self.backImageView.contentMode = .scaleAspectFit
        
        self.appleSignIn.image = UIImage(named: "SignInWithApple")
        self.appleSignIn.contentMode = .scaleAspectFit
    }
    
    private func setupAutoLayout() {
        
        NSLayoutConstraint.activate([
            
            self.titleStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.titleStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.titleStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 56),
            
            self.backImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.appleSignIn.widthAnchor.constraint(equalToConstant: Metric.sigInLogoSize.width),
            self.appleSignIn.heightAnchor.constraint(equalToConstant: Metric.sigInLogoSize.height),
            self.appleSignIn.centerXAnchor.constraint(equalTo: self.backImageView.centerXAnchor),
            self.appleSignIn.centerYAnchor.constraint(equalTo: self.backImageView.centerYAnchor)
        ])
    }
    
    private func bindView() {
        
        self.appleSignIn.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .bind(onNext: { $0.0.signInTapped() })
            .disposed(by: self.disposeBag)
        
        self.viewModel.showAssociationView
            .withUnretained(self)
            .bind(onNext: { $0.0.navigationController?.pushViewController(AssociationViewController(), animated: true) })
            .disposed(by: self.disposeBag)
        
        self.viewModel.showMainView
            .withUnretained(self)
            .bind(onNext: { $0.0.navigationController?.popViewController(animated: true) })
            .disposed(by: self.disposeBag)
    }
    
    
    private func signInTapped() {
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension SignUpViewController: ASAuthorizationControllerDelegate {
    
}

extension SignUpViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // 인증 컨트롤러가 표시될 앵커(Anchor)를 반환합니다.
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        // 로그인이 성공적으로 완료되었을 때의 처리를 구현합니다.
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            // Apple ID 관련 정보를 사용하여 로그인 처리를 수행합니다.
            let userIdentifier = appleIDCredential.user
//            let fullName = appleIDCredential.fullName
//            let email = appleIDCredential.email
            
            // 필요한 추가적인 처리를 수행합니다.
            debugPrint("userIdentifier: \(userIdentifier)")
            
            KeychainService.shared.saveAppleIdentifier(userIdentifier)
            
            self.viewModel.checkUserInfo(userIdentifier)
//            self.viewModel.signInStarted(userIdentifier)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // 로그인 과정 중에 에러가 발생했을 때의 처리를 구현합니다.
        // 에러를 적절하게 처리하는 코드를 작성하세요.
    }
}
