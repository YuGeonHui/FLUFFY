//
//  NicknameChangeViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/05.
//

import UIKit
import RxCocoa
import RxSwift
import RxGesture
import SwiftRichString
import Alamofire

final class NicknameChangeViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private enum Metric {
        
        static let btnHeight: CGFloat = 53
    }
    
    private enum Styles {
        
        static let desc: Style = Style {
            $0.font = UIFont.pretendard(.medium, size: 13)
            $0.color = UIColor(hex: "a1a1a1")
            $0.minimumLineHeight = 20
            $0.maximumLineHeight = 20
        }
        
        static let nicknameField: Style = Style {
            $0.font = UIFont.pretendard(.semiBold, size: 18)
            $0.color = UIColor(hex: "cecece")
        }
        
        static let caution: Style = Style {
            $0.font = UIFont.pretendard(.regular, size: 12)
            $0.color = UIColor(hex: "ff0000")
        }
    }
    
    private let descLabel = UILabel()
    
    private let nicknameField = UITextField()
    
    private let dividerView = DividerView()
    
    private let cautionLabel = UILabel()
    
    private let signOutView = MyPageRowView(title: "로그아웃")
    
    private let withdrawView = MyPageRowView(title: "회원탈퇴")
    
    private let saveButton = CommonButtonView(background: UIColor(hex: "000000"), title: "시작하기")
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: "f9f9f9")
        
        self.setupViews()
        self.setupNicknameField()
        self.setupAutoLayout()
        self.bindView()
    }
    
    private func setupViews() {
        
        self.descLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nicknameField.translatesAutoresizingMaskIntoConstraints = false
        self.dividerView.translatesAutoresizingMaskIntoConstraints = false
        self.cautionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false
        self.signOutView.translatesAutoresizingMaskIntoConstraints = false
        self.withdrawView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(descLabel)
        self.view.addSubview(dividerView)
        self.view.addSubview(nicknameField)
        self.view.addSubview(cautionLabel)
        self.view.addSubview(saveButton)
        self.view.addSubview(signOutView)
        self.view.addSubview(withdrawView)
        
        self.descLabel.attributedText = "한글 및 영문, 숫자, 특수문자 만 사용 가능하며 최소 2글자 이상,\n최대 10자 이하까지만 등록 가능합니다.".set(style: Styles.desc)
        self.descLabel.numberOfLines = 0
        
        self.saveButton.isUserInteractionEnabled = false
    }
    
    private let apiworker = NetworkService()
    
    private func setupNicknameField() {
        
//        let nickname = UserDefaults.standard.string(forKey: NICKNAME_KEY)
//
//        guard let nickname = nickname else { return }
//
//        self.nicknameField.attributedText = nickname.set(style: Styles.nicknameField)
        self.nicknameField.attributedPlaceholder = "닉네임 입력".set(style: Styles.nicknameField)
        self.nicknameField.clearButtonMode = .whileEditing
    }
    
    private func setupAutoLayout() {
        
        NSLayoutConstraint.activate([
            
            self.descLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 33),
            self.descLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.descLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            self.nicknameField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.nicknameField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.nicknameField.topAnchor.constraint(equalTo: self.descLabel.bottomAnchor, constant: 20),
            
            self.dividerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.dividerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.dividerView.topAnchor.constraint(equalTo: self.nicknameField.bottomAnchor, constant: 7),
            self.dividerView.widthAnchor.constraint(equalToConstant: 350),
            self.dividerView.heightAnchor.constraint(equalToConstant: 1),
            
            self.cautionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.cautionLabel.topAnchor.constraint(equalTo: self.dividerView.bottomAnchor, constant: 7),
            
            self.signOutView.topAnchor.constraint(equalTo: self.dividerView.bottomAnchor, constant: 58),
            self.signOutView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.signOutView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.withdrawView.topAnchor.constraint(equalTo: self.signOutView.bottomAnchor, constant: 20),
            self.withdrawView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.withdrawView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            self.saveButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.saveButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.saveButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            self.saveButton.heightAnchor.constraint(equalToConstant: Metric.btnHeight)
        ])
    }
    
    private func bindView() {
        
        self.nicknameField.rx.text.orEmpty
            .filter { $0.count > 0 }
            .withUnretained(self)
            .bind(onNext: { $0.0.setValidateInput($0.1) })
            .disposed(by: self.disposeBag)
        
        self.signOutView.buttonTapped
            .withUnretained(self)
            .bind(onNext: { $0.0.signOutTapped() })
            .disposed(by: self.disposeBag)
        
        self.withdrawView.buttonTapped
            .withUnretained(self)
            .bind(onNext: { $0.0.withdrawTapped() })
            .disposed(by: self.disposeBag)
        
        self.saveButton.rx.tap
            .withUnretained(self)
            .bind(onNext: { $0.0.saveButtonTapped() })
            .disposed(by: self.disposeBag)
    }
}

extension NicknameChangeViewController {
    
    private func signOutTapped() {
        KeychainService.shared.deleteToken()
    }
    
    private func withdrawTapped() {
        
        guard let token = KeychainService.shared.loadToken() else { return }
        
        let url = AccountAPI.remove.url
        let headers: HTTPHeaders? = HTTPHeaders([FlUFFYAPI.Header.authFieldName: FlUFFYAPI.Header.auth(token).value])
        
        self.apiworker.getRequest(url: url, method: .delete, headers: headers) {(result: Result<AccountRemoveResponse, Error>) in
            switch result {
            case .success(let response):
                
                print(response)
                
                self.navigationController?.popViewController(animated: true)
                KeychainService.shared.deleteToken()
                
                // 화면닫기 이후 갱신 필요
                
            case .failure(let error):
                
                print(error)
            }
        }
    }
    
    private func saveButtonTapped() {
        
        UserDefaults.standard.set(nicknameField.text, forKey: NICKNAME_KEY)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setValidateInput(_ text: String?) {
        
        guard let text = text else {
            
            self.dividerView.backgroundColor = UIColor(hex: "b1b1b1")
            self.cautionLabel.attributedText = "".set(style: Styles.caution)
            self.saveButton.isUserInteractionEnabled = true
            return
        }
        
        if validateInput(text) {
            
            self.dividerView.backgroundColor = UIColor(hex: "b1b1b1")
            self.cautionLabel.attributedText = "".set(style: Styles.caution)
            self.saveButton.isUserInteractionEnabled = true
            
        } else {
            
            self.dividerView.backgroundColor = UIColor(hex: "ff0000")
            self.cautionLabel.attributedText = "사용 불가한 닉네임입니다.".set(style: Styles.caution)
            self.saveButton.isUserInteractionEnabled = false
        }
    }
    
    func validateInput(_ input: String) -> Bool {
        let pattern = "^[a-zA-Z0-9가-힣!@#$%^&*()-_=+\\\\\\|[{]};:'\",<.>/?\\s]{2,10}$"
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: input.utf16.count)
        let matches = regex.matches(in: input, range: range)
        return matches.count > 0
    }
}
