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
    
    private let apiService = NetworkService()
    
    // MARK: Values
    private let _viewValue = BehaviorRelay<HomeViewResponse?>(value: nil)
    var valueChanged: Observable<HomeViewResponse?> {
        return self._viewValue.asObservable()
    }
    
    override func bind() {
        
    }
}
