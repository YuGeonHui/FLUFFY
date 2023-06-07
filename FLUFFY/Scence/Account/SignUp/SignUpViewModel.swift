//
//  SignUpViewModel.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/03.
//

import UIKit
import RxCocoa
import RxSwift
import Alamofire

final class SignUpViewModel: RxViewModel {
    
    private let _checkUserInfo = PublishRelay<String>()
    func checkUserInfo(_ userIdentifier: String) {
        self._checkUserInfo.accept(userIdentifier)
    }
    
    private let _signInStarted = PublishRelay<String>()
    func signInStarted(_ userIdentifier: String) {
        self._signInStarted.accept(userIdentifier)
    }
    
    private let _showAssociationView = PublishRelay<Void>()
    var showAssociationView: Observable<Void> {
        return self._showAssociationView.asObservable()
    }
    
    private let _finishSignIn = PublishRelay<Void>()
    var showMainView: Observable<Void> {
        return self._finishSignIn.asObservable()
    }
    
    private let apiworker = NetworkService()
    
    override func bind() {
        
        self._checkUserInfo
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .bind(onNext: { $0.0.postBodyJsonRequest($0.1) })
            .disposed(by: self.disposeBag)
        
        self._signInStarted
            .withUnretained(self)
            .bind(onNext: { $0.0.signIn($0.1) })
            .disposed(by: self.disposeBag)
    }
        
    func postBodyJsonRequest(_ userIdentifier: String) {
        
        let url = AccountAPI.check.url
        let bodyData = CheckUserInfoRequest(uuid: userIdentifier).dictionary
        let header : HTTPHeaders = ["Content-Type" : "application/json"]
        
        AF.request(
            url, // [주소]
            method: .post, // [전송 타입]
            parameters: bodyData, // [전송 데이터]
            encoding: JSONEncoding.default, // [인코딩 스타일]
            headers: header // [헤더 지정]
        )
        .validate(statusCode: 200..<300)
        .responseData { response in
            switch response.result {
            case .success(let res):
                do {
                    print("응답 코드 :: ", response.response?.statusCode ?? 0)
                    print("응답 데이터 :: ", String(data: res, encoding: .utf8) ?? "")

                    guard let statusCode = response.response?.statusCode else { return }
                    
                    if statusCode == 200 {
                        
                        self._signInStarted.accept(userIdentifier)
                        
                    } else if statusCode == 201 {
                        
                        self._showAssociationView.accept(())
                    }
                } catch (let err) {
                    print("catch :: ", err.localizedDescription)
                }
                break
            case .failure(let err): print(err.localizedDescription)
                break
            }
        }
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
                self._finishSignIn.accept(())
              
                
            case .failure(let error):
                
                print(error.localizedDescription)
            }
        })
    }
}

