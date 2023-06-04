//
//  AssociationRowView.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/03.
//

import UIKit
import SwiftRichString
import RxSwift
import RxGesture
import RxCocoa

final class AssociationRowView: UIView {
    
    private let disposeBag = DisposeBag()
    
    private(set) var title: String
    
    private enum Metric {
        
        static let checkSize: CGSize = CGSize(width: 28, height: 28)
        static let height: CGFloat = 28
        static let titleSpacing: CGFloat = 13
    }
    
    private enum Styles {
        
        static let title: Style = Style {
            $0.font = UIFont.pretendard(.medium, size: 15)
            $0.color = UIColor(hex: "2d2d2d")
        }
        
        static let show: Style = Style {
            $0.font = UIFont.pretendard(.medium, size: 15)
            $0.color = UIColor(hex: "989898")
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
    
    private let checkImageView = UIImageView()
    
    private let titleLabel = UILabel()
    
    private let showLabel = UILabel()
    
    private lazy var titleStackView = UIStackView(arrangedSubviews: [checkImageView, titleLabel])
    
    private lazy var rowStackView = UIStackView(arrangedSubviews: [titleStackView, showLabel])
    
    private let _agreeTapped = PublishRelay<Bool>()
    var agreeTapped: Observable<Bool> {
        return self._agreeTapped.asObservable()
    }
    
    private let _showTapped = PublishRelay<Void>()
    var showTapped: Observable<Void> {
        return self._showTapped.asObservable()
    }
    
    private func setupViews() {
        
        self.rowStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(rowStackView)
        
        self.checkImageView.image = UIImage(named: "checkBlack")
        self.checkImageView.contentMode = .scaleAspectFit
        
        self.titleLabel.attributedText = self.title.set(style: Styles.title)
        self.showLabel.attributedText = "보기".set(style: Styles.show)
        
        self.titleStackView.axis = .horizontal
        self.titleStackView.spacing = Metric.titleSpacing
        self.titleStackView.distribution = .fill
        
        self.rowStackView.axis = .horizontal
        self.rowStackView.alignment = .center
        self.rowStackView.distribution = .fill
    }
    
    private func setupAutoLayout() {
        
        NSLayoutConstraint.activate([
            
            self.checkImageView.widthAnchor.constraint(equalToConstant: Metric.checkSize.width),
            self.checkImageView.heightAnchor.constraint(equalToConstant: Metric.checkSize.height),
            
            self.heightAnchor.constraint(equalToConstant: Metric.height)
        ])
    }
}

// MARK: Bindings
extension AssociationRowView {
    
    private func bindView() {
        
        //        self.checkImageView.rx.tapGesture()
        //            .when(.recognized)
        //            .withUnretained(self)
        //            .bind(onNext: { $0.0._agreeTapped.accept($0.1) })
        //            .disposed(by: self.disposeBag)
        //
        //        self._agreeTapped
        //            .withUnretained(self)
        //            .bind(onNext: { $0.0.changeAgreeState($0.1) })
        //            .disposed(by: self.disposeBag)
        //
        //        self._showTapped
        //            .withUnretained(self)
        //            .bind(onNext: { $0 })
        //            .disposed(by: self.disposeBag)
    }
    
    private func changeAgreeState(_ state: Bool) {
        self.checkImageView.image = state ? UIImage(named: "checkRed") : UIImage(named: "checkBlack")
    }
}
