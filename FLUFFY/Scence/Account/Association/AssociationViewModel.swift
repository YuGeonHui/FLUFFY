//
//  AssociationViewModel.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/03.
//

import UIKit
import SwiftRichString
import RxSwift
import RxGesture
import RxCocoa

final class AssociationViewModel: RxViewModel {
    
    private let _nextTapped = PublishRelay<Void>()
    func nextTap() {
        self._nextTapped.accept(())
    }
    
    private let _showNicknameView = PublishRelay<Void>()
    var showNicknameView: Observable<Void> {
        return self._showNicknameView.asObservable()
    }
    
    override func bind() {
        super.bind()
        
        self._nextTapped
            .withUnretained(self)
            .bind(onNext: { $0.0._showNicknameView.accept($0.1) })
            .disposed(by: self.disposeBag)
    }
}
