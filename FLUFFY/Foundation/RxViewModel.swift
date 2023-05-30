//
//  RxViewModel.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/30.
//

import Foundation
import RxSwift

protocol RxViewModelType {
    
    var disposeBag: DisposeBag { get set }
    
    func bind()
    func unbind()
}

class RxViewModel: NSObject, RxViewModelType {
    
    var disposeBag = DisposeBag()
    
    func bind() {
        
    }
    
    func unbind() {
        self.disposeBag = DisposeBag()
    }
}
