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
    
    private let _signInStarted = PublishRelay<String>()
    func signInStarted(_ userIdentifier: String) {
        self._signInStarted.accept(userIdentifier)
    }
    
    private let _showAssociationView = PublishRelay<Void>()
    var showAssociationView: Observable<Void> {
        return self._showAssociationView.asObservable()
    }
    
    private let apiworker = NetworkService()
    
    override func bind() {
        
        self._signInStarted
            .withUnretained(self)
            .bind(onNext: { $0.0.signIn($0.1) })
            .disposed(by: self.disposeBag)
    }
    
    private func signIn(_ userIdentifier: String) {
        
        let url = AccountAPI.signIn.url
        let request = AccountSignInRequest(uuid: userIdentifier)
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: request.dictionary) else {
            print("Failed to convert parameters to JSON data")
            return
        }
        
//        debugPrint("jsonData: \(jsonData)")
        
        self.apiworker.performRequest(url: url, method: .post, parameters: jsonData, headers: nil) { (result: Result<AccountResponse, Error>) in
            
            switch result {
            case .success(let response):
                // 성공적으로 응답을 받았을 때의 처리
                print("Response:", response)
                let token = response.msg
                KeychainService.shared.saveToken(token: token)
                
                self._showAssociationView.accept(())
                
            case .failure(let error):
                // 통신 중 에러가 발생했을 때의 처리
                self._showAssociationView.accept(())
                
                print("Error:", error)
            }
        }
    }
}

