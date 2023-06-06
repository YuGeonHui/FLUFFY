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
    
    private let startButton = CommonButtonView(background: UIColor(hex: "000000"), title: "시작하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: "f9f9f9")
        
        self.setupViews()
        self.setupAutoLayout()
        self.bindView()
    }
    
    private func setupViews() {
        
        self.descLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nicknameField.translatesAutoresizingMaskIntoConstraints = false
        self.dividerView.translatesAutoresizingMaskIntoConstraints = false
        self.cautionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.startButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(descLabel)
        self.view.addSubview(dividerView)
        self.view.addSubview(nicknameField)
        self.view.addSubview(cautionLabel)
        self.view.addSubview(startButton)
        
        self.descLabel.attributedText = "한글 및 영문, 숫자, 특수문자 만 사용 가능하며 최소 2글자 이상,\n최대 10자 이하까지만 등록 가능합니다.".set(style: Styles.desc)
        self.descLabel.numberOfLines = 0
        
        self.nicknameField.attributedPlaceholder = "닉네임 입력".set(style: Styles.nicknameField)
        self.nicknameField.clearButtonMode = .whileEditing
        
        self.startButton.isUserInteractionEnabled = false
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
            
            self.startButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.startButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.startButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            self.startButton.heightAnchor.constraint(equalToConstant: Metric.btnHeight)
        ])
    }
    
    private func bindView() {
        
        self.nicknameField.rx.text.orEmpty
            .filter { $0.count > 0 }
            .withUnretained(self)
            .bind(onNext: { $0.0.setValidateInput($0.1) })
            .disposed(by: self.disposeBag)
    }
}



extension NicknameChangeViewController {
    
    private func setValidateInput(_ text: String?) {
        
        guard let text = text else {
            
            self.dividerView.backgroundColor = UIColor(hex: "b1b1b1")
            self.cautionLabel.attributedText = "".set(style: Styles.caution)
            self.startButton.isUserInteractionEnabled = true
            return
        }
        
        if validateInput(text) {
            
            self.dividerView.backgroundColor = UIColor(hex: "b1b1b1")
            self.cautionLabel.attributedText = "".set(style: Styles.caution)
            self.startButton.isUserInteractionEnabled = true
            
        } else {
            
            self.dividerView.backgroundColor = UIColor(hex: "ff0000")
            self.cautionLabel.attributedText = "사용 불가한 닉네임입니다.".set(style: Styles.caution)
            self.startButton.isUserInteractionEnabled = false
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
