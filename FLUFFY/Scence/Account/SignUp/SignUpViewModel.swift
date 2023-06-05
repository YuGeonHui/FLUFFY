//
//  SignUpViewModel.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/03.
//

import UIKit
import RxCocoa
import RxSwift

final class SignUpViewModel: RxViewModel {
    
    private let _signInTapped = PublishRelay<Void>()
    func signInTapped() {
        self._signInTapped.accept(())
    }
    
    override func bind() {
        
    }
}
