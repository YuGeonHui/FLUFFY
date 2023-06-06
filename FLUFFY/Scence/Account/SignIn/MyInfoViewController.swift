//
//  MyInfoViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/31.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftRichString

final class MyInfoViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let titleLabel = UILabel()
    
    private let descLabel = UILabel()
    
    private let nicknameField = UITextField()
    
    private lazy var titleStackViwe = UIStackView(arrangedSubviews: [titleLabel, descLabel])
    
    private let dividerView = DividerView()
    
    private let imageView = UIImageView()
    
    private let cautionLabel = UILabel()
    
    private let startButton = CommonButtonView(background: UIColor(hex: "000000"), title: "시작하기")
    
    private enum Metric {
        
        static let titleSpacing: CGFloat = 18
        
        static let btnHeight: CGFloat = 53
    }
    
    private enum Styles {
        
        static let fluffy: Style = Style {
            $0.font = UIFont.candyBean(.normal, size: 25)
            $0.color = UIColor(hex: "2d2d2d")
            $0.minimumLineHeight = 32
            $0.maximumLineHeight = 32
        }
        
        static let title: Style = Style {
            $0.font = UIFont.pretendard(.bold, size: 25)
            $0.color = UIColor(hex: "2d2d2d")
            $0.minimumLineHeight = 32
            $0.maximumLineHeight = 32
        }
        
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
    
    private let viewModel = MyInfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: "f9f9f9")
        
        self.setupViews()
        self.setupAutoLayout()
        self.bindView()
        
        self.viewModel.bind()
    }
    
    deinit {
        self.viewModel.unbind()
    }
    
    private func setupViews() {
        
        self.titleStackViwe.translatesAutoresizingMaskIntoConstraints = false
        self.startButton.translatesAutoresizingMaskIntoConstraints = false
        self.nicknameField.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.dividerView.translatesAutoresizingMaskIntoConstraints = false
        self.cautionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(titleStackViwe)
        self.view.addSubview(startButton)
        self.view.addSubview(nicknameField)
        self.view.addSubview(imageView)
        self.view.addSubview(dividerView)
        self.view.addSubview(cautionLabel)
        
        let style = StyleXML(base: Styles.title, ["b": Styles.fluffy])
        self.titleLabel.attributedText = "<b>Fluffy</b>에서 사용할\n닉네임을 입력해주세요!".set(style: style)
        self.titleLabel.numberOfLines = 0
        
        self.descLabel.attributedText = "한글 및 영문, 숫자, 특수문자 만 사용 가능하며 최소 2글자 이상,\n최대 10자 이하까지만 등록 가능합니다.".set(style: Styles.desc)
        self.descLabel.numberOfLines = 0
        
        self.nicknameField.attributedPlaceholder = "닉네임 입력".set(style: Styles.nicknameField)
        self.nicknameField.clearButtonMode = .whileEditing
        
        self.titleStackViwe.axis = .vertical
        self.titleStackViwe.alignment = .leading
        self.titleStackViwe.distribution = .fill
        self.titleStackViwe.spacing = Metric.titleSpacing
        
        self.imageView.image = UIImage(named: "nicknameBackground")
        self.imageView.contentMode = .scaleAspectFit
    }
    
    private func setupAutoLayout() {
        
        NSLayoutConstraint.activate([
            titleStackViwe.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleStackViwe.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            titleStackViwe.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 56),
            
            self.nicknameField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.nicknameField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.nicknameField.topAnchor.constraint(equalTo: self.titleStackViwe.bottomAnchor, constant: 30),
            
            self.dividerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.dividerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.dividerView.topAnchor.constraint(equalTo: self.nicknameField.bottomAnchor, constant: 7),
            self.dividerView.widthAnchor.constraint(equalToConstant: 350),
            self.dividerView.heightAnchor.constraint(equalToConstant: 1),
            
            self.cautionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.cautionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 20),
            self.cautionLabel.topAnchor.constraint(equalTo: self.dividerView.bottomAnchor, constant: 7),
            
            self.imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 120),
            self.imageView.bottomAnchor.constraint(equalTo: self.startButton.topAnchor, constant: -70),
//
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
        
        self.startButton.rx.tap
            .withUnretained(self)
            .bind(onNext: {
                
                guard let userId = KeychainService.shared.loadAppleIdentifier(), let nickname = self.nicknameField.text else {
                    debugPrint("no userId")
                    return
                }
                
                $0.0.viewModel.signUpStarted(userId, nickname)
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.showMainView
            .withUnretained(self)
            .bind(onNext: {
                
                UserDefaults.standard.set(self.nicknameField.text, forKey: NICKNAME_KEY)
                
                let mainViewController = TabBarViewController()
                mainViewController.modalPresentationStyle = .fullScreen
                
                $0.0.present(mainViewController, animated: true)
            })
            .disposed(by: self.disposeBag)
    }
    
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
