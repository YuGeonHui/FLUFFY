//
//  MyInfoViewModel.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/31.
//

import UIKit
import RxCocoa
import RxSwift

final class MyInfoViewModel: RxViewModel {
    
    // MARK: Inputs
    private let _signUpStarted = PublishRelay<(String, String)>()
    func signUpStarted(_ userIdentifier: String, _ nickname: String) {
        self._signUpStarted.accept((userIdentifier, nickname))
    }
    
    // MARK: Outputs
    private let _showMainView = PublishRelay<Void>()
    var showMainView: Observable<Void> {
        return self._showMainView.asObservable()
    }
    
    private let apiworker = NetworkService()
    
    override func bind() {
        
        self._signUpStarted
            .withUnretained(self)
            .bind(onNext: { $0.0.signUp($0.1.0, $0.1.1) })
            .disposed(by: self.disposeBag)
    }
    
    private func signUp(_ userIdentifier: String, _ nickname: String) {
        
        let url = AccountAPI.signUp.url
        let request = AccountSignUpRequest(uuid: userIdentifier, nickname: nickname)
        
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
                
                self._showMainView.accept(())
                
            case .failure(let error):
                // 통신 중 에러가 발생했을 때의 처리
                
                self._showMainView.accept(())
                
                print("Error:", error)
            }
        }
    }
}
