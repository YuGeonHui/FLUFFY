//
//  AssociationViewController.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/03.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftRichString

final class AssociationViewController: UIViewController {
    
    private let disposedBag = DisposeBag()
    
    private enum Metric {
        
        static let logoSize: CGSize = CGSize(width: 89, height: 28)
        
        static let stackSpacing: CGFloat = 18
        
        static let allAgreeBtnSize: CGSize = CGSize(width: 26, height: 26)
        
        static let allAgreeSpacing: CGFloat = 14
        
        static let btnHeight: CGFloat = 53
    }
    
    private enum Styles {
        
        static let title: Style = Style {
            $0.font = UIFont.pretendard(.bold, size: 25)
            $0.color = UIColor(hex: "2d2d2d")
        }
        
        static let desc: Style = Style {
            $0.font = UIFont.pretendard(.medium, size: 15)
            $0.color = UIColor(hex: "656565")
            $0.minimumLineHeight = 24
            $0.maximumLineHeight = 24
        }
        
        static let allAgree: Style = Style {
            $0.font = UIFont.pretendard(.bold, size: 18)
            $0.color = UIColor(hex: "2d2d2d")
        }
    }
    
    private let logoImgView = UIImageView()

    private let titleLabel = UILabel()

    private let descLabel = UILabel()
    
    private lazy var titleStackView = UIStackView(arrangedSubviews: [logoImgView, titleLabel, descLabel])

    private let nextButton = CommonButtonView(background: UIColor(hex: "000000"), title: "다음")
    
    private let associationView = AssociationRowView(title: "이용약관 동의 (필수)")
    
    private let dividerView = DividerView()
    
    private let allAgreeImgeView = UIImageView()
    
    private let allAgreeTitleLabel = UILabel()
    
    private lazy var allAgreeStackView = UIStackView(arrangedSubviews: [allAgreeImgeView, allAgreeTitleLabel])
    
    // MARK: ViewModel
    private let viewModel = AssociationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(hex: "F9F9F9")
        
        self.setupViews()
        self.setupAutoLayout()
        self.bindView()
        
        viewModel.bind()
    }
    
    private func setupViews() {
     
        self.titleStackView.translatesAutoresizingMaskIntoConstraints = false
        self.associationView.translatesAutoresizingMaskIntoConstraints = false
        self.dividerView.translatesAutoresizingMaskIntoConstraints = false
        self.allAgreeStackView.translatesAutoresizingMaskIntoConstraints = false
        self.nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(titleStackView)
        self.view.addSubview(associationView)
        self.view.addSubview(dividerView)
        self.view.addSubview(allAgreeStackView)
        self.view.addSubview(nextButton)
        
        self.logoImgView.image = UIImage(named: "fluffy_logo")
        self.logoImgView.contentMode = .scaleAspectFit
        
        self.titleLabel.attributedText = "이용약관 동의".set(style: Styles.title)
        self.descLabel.attributedText = "플러피가 제공하는 서비스를 이용하시려면\n약관에 동의가 필요합니다.".set(style: Styles.desc)
        self.descLabel.numberOfLines = 2
        
        self.titleStackView.axis = .vertical
        self.titleStackView.alignment = .leading
        self.titleStackView.spacing = Metric.stackSpacing
        
        self.allAgreeImgeView.image = UIImage(named: "allCheck")
        self.allAgreeImgeView.contentMode = .scaleAspectFit
        self.allAgreeTitleLabel.attributedText = "약관 전체동의".set(style: Styles.allAgree)
        
        self.allAgreeStackView.spacing = Metric.allAgreeSpacing
        self.allAgreeStackView.axis = .horizontal
        self.allAgreeStackView.alignment = .center
        self.allAgreeStackView.distribution = .fill
    }
    
    private func setupAutoLayout() {
        
        NSLayoutConstraint.activate([
            self.titleStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.titleStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.titleStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 56),
            
            self.associationView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.associationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.associationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            self.dividerView.topAnchor.constraint(equalTo: self.associationView.bottomAnchor, constant: 14),
            self.dividerView.widthAnchor.constraint(equalToConstant: 350),
            self.dividerView.heightAnchor.constraint(equalToConstant: 1),
            self.dividerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.allAgreeImgeView.widthAnchor.constraint(equalToConstant: Metric.allAgreeBtnSize.width),
            self.allAgreeImgeView.heightAnchor.constraint(equalToConstant: Metric.allAgreeBtnSize.height),
            
            self.allAgreeStackView.topAnchor.constraint(equalTo: self.dividerView.bottomAnchor, constant: 19),
            self.allAgreeStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.allAgreeStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            self.nextButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.nextButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.nextButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            self.nextButton.heightAnchor.constraint(equalToConstant: Metric.btnHeight)
        ])
    }
    
    deinit {
        viewModel.unbind()
    }
}

extension AssociationViewController {
    
    private func bindView() {
        
        self.nextButton.rx.tap
            .withUnretained(self.viewModel)
            .bind(onNext: { $0.0.nextTap() })
            .disposed(by: self.disposedBag)
        
        self.viewModel.showNicknameView
            .withUnretained(self)
            .bind(onNext: { $0.0.showNicknameView() })
            .disposed(by: self.disposedBag)
    }
    
    private func showNicknameView() {
        
        let signInVC = MyInfoViewController()
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
}

