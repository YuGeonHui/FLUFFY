//
//  HomeViewModel.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModelInputs {
    
}

protocol HomeViewModelOutputs {
    
}

final class HomeViewModel: RxViewModel, HomeViewModelInputs, HomeViewModelOutputs {
    
    private let _tapToolTip = PublishRelay<Void>()
    func tapToolTip() {
        self._tapToolTip.accept(())
    }
    
    private let _showToolTip = PublishRelay<Void>()
    var showToolTip: Observable<Void> {
        return self._showToolTip.asObservable()
    }
    
    override func bind() {
        
        self._tapToolTip
            .withUnretained(self)
            .bind(onNext: { $0._showToolTip.accept($1) })
            .disposed(by: self.disposeBag)
    }
}
