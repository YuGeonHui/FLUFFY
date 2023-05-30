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
        
        debugPrint("메모리에서 제거")
        
        self.disposeBag = DisposeBag()
    }
}
