//
//  MyPageRowView.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/01.
//

import UIKit
import SwiftRichString
import RxSwift
import RxGesture
import RxCocoa

final class MyPageRowView: UIView {
    
    private let disposeBag = DisposeBag()
    
    private(set) var title: String
    private(set) var hasVersion: Bool
    
    private enum Metric {
        
        static let arrowSize: CGSize = CGSize(width: 24, height: 24)
        static let height: CGFloat = 36
        
        static let spacing: CGFloat = 20
        static let versionSpacing: CGFloat = 30
    }
    
    private enum Styles {
        
        static var title: Style = Style {
            $0.font = UIFont.pretendard(.semiBold, size: 18)
            $0.color = UIColor(hex: "2d2d2d")
        }
        
        static var version: Style = Style {
            $0.font = UIFont.pretendard(.regular, size: 16)
            $0.color = UIColor(hex: "8c8c8c")
        }
    }
    
    init(frame: CGRect, title: String, hasVersion: Bool) {
        
        self.title = title
        self.hasVersion = hasVersion
        
        super.init(frame: frame)
        
        self.setupViews()
        self.setupAutoLayout()
        self.bindView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, hasVersion: Bool = false) {
        self.init(frame: .zero, title: title, hasVersion: hasVersion)
    }

    private let _tapped = PublishRelay<Void>()
    var buttonTapped: Observable<Void> {
        return self._tapped.asObservable()
    }
    
    private let titleLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let versionLabel = UILabel()

    private func setupViews() {
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        self.versionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(titleLabel)
        self.addSubview(versionLabel)
        self.addSubview(arrowImageView)
        
        self.versionLabel.isHidden = !hasVersion
        self.arrowImageView.isHidden = hasVersion
        
        self.arrowImageView.image = UIImage(named: "Expand_right")
        self.arrowImageView.contentMode = .scaleAspectFit
        self.titleLabel.attributedText = self.title.set(style: Styles.title)
        
        self.versionLabel.attributedText = "v.\(Bundle.main.appVersion)".set(style: Styles.version)
    }
    
    private func setupAutoLayout() {
        
        NSLayoutConstraint.activate([
            
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metric.spacing),
            self.arrowImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metric.spacing),
            self.arrowImageView.widthAnchor.constraint(equalToConstant: Metric.arrowSize.width),
            self.arrowImageView.heightAnchor.constraint(equalToConstant: Metric.arrowSize.height),
            
            self.versionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metric.versionSpacing),
            
            self.heightAnchor.constraint(equalToConstant: Metric.height)
        ])
    }
    
    private func bindView() {
        
        self.rx.tapGesture()
            .when(.recognized)
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { $0.0._tapped.accept(()) })
            .disposed(by: self.disposeBag)
    }
}
