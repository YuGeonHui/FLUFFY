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
    
    private enum Metric {
        
        static let arrowSize: CGSize = CGSize(width: 24, height: 24)
        static let height: CGFloat = 36
    }
    
    private enum Styles {
        
        static var title: Style = Style {
            $0.font = UIFont.pretendard(.semiBold, size: 18)
            $0.color = UIColor(hex: "2d2d2d")
        }
    }
    
    init(frame: CGRect, title: String) {
        self.title = title
        super.init(frame: frame)
        
        self.setupViews()
        self.setupAutoLayout()
        self.bindView()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init(frame: .zero, title: title)
    }

    private let _tapped = PublishRelay<Void>()
    var buttonTapped: Observable<Void> {
        return self._tapped.asObservable()
    }
    
    private let titleLabel = UILabel()
    private let arrowImageView = UIImageView()

    private func setupViews() {
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(titleLabel)
        self.addSubview(arrowImageView)
        
        self.arrowImageView.image = UIImage(named: "Expand_right")
        self.arrowImageView.contentMode = .scaleAspectFit
        
        self.titleLabel.attributedText = self.title.set(style: Styles.title)
    }
    
    private func setupAutoLayout() {
        
        NSLayoutConstraint.activate([
            
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.arrowImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            self.arrowImageView.widthAnchor.constraint(equalToConstant: Metric.arrowSize.width),
            self.arrowImageView.heightAnchor.constraint(equalToConstant: Metric.arrowSize.height),
            
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
