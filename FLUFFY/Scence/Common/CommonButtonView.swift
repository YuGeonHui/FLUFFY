//
//  CommonButtonView.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/03.
//

import UIKit
import RxSwift
import RxGesture
import RxCocoa
import SwiftRichString

final class CommonButtonView: UIButton {
    
    private let disposeBag = DisposeBag()
    
    private enum Styles {
        static let title: Style = Style {
            $0.font = UIFont.pretendard(.medium, size: 18)
        }
    }
    
    private(set) var background: UIColor?
    private(set) var title: String?
    var titleColor: UIColor = .white {
        didSet {
            self.setTitleColor(self.titleColor, for: .normal)
        }
    }
    
    init(frame: CGRect, background: UIColor, title: String) {
        
        self.title = title
        self.background = background
        
        super.init(frame: frame)
        
        self.setupButton()
        self.bindView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(background: UIColor, title: String) {
        self.init(frame: .zero, background: background, title: title)
    }
    
    private func setupButton() {
        
        self.titleLabel?.font = UIFont.pretendard(.medium, size: 18)
        
        self.setTitle(self.title, for: .normal)
        
        self.backgroundColor = self.background
        
        self.layer.cornerRadius = 5
    }
    
    private let _tapped = PublishRelay<Void>()
    var buttonTapped: Observable<Void> {
        return self._tapped.asObservable()
    }
    
    private func bindView() {
     
        self.rx.tap
            .withUnretained(self)
            .bind(onNext: { $0.0._tapped.accept(()) })
            .disposed(by: self.disposeBag)
    }
}
