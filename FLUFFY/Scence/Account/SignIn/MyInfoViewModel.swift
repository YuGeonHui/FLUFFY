//
//  MyInfoViewModel.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/31.
//

import UIKit
import RxCocoa
import Alamofire
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
        let request = AccountSignUpRequest(uuid: userIdentifier, nickname: nickname).dictionary
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        
        AF.request(
            url, // [주소]
            method: .post, // [전송 타입]
            parameters: request, // [전송 데이터]
            encoding: JSONEncoding.default, // [인코딩 스타일]
            headers: header // [헤더 지정]
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: AccountResponse.self, completionHandler: { response in
            
            switch response.result {
                
            case .success(let value):

                // result -> Token
                debugPrint("signup Finish!!!!!: \(value.token)")
                
                UserDefaults.standard.set(nickname, forKey: NICKNAME_KEY)
                self.signIn(userIdentifier)
//                self._showMainView.accept(())
                
            case .failure(let error):
                
                print(error.localizedDescription)
            }
        })
    }
    
    private func signIn(_ userIdentifier: String) {
        
        let url = AccountAPI.signIn.url
        let request = AccountSignInRequest(uuid: userIdentifier).dictionary
        let header : HTTPHeaders = ["Content-Type" : "application/json"]
        
        AF.request(
            url, // [주소]
            method: .post, // [전송 타입]
            parameters: request, // [전송 데이터]
            encoding: JSONEncoding.default, // [인코딩 스타일]
            headers: header // [헤더 지정]
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: AccountResponse.self, completionHandler: { response in
            
            switch response.result {
                
            case .success(let value):
                
                let token = value.token
                KeychainService.shared.saveToken(token: token)
                
                debugPrint("token: \(token)")
                self._showMainView.accept(())
                
            case .failure(let error):
                
                print(error.localizedDescription)
            }
        })
    }
}
