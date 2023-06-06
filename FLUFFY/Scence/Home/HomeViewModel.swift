//
//  HomeViewModel.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

protocol HomeViewModelInputs {
    
}

protocol HomeViewModelOutputs {
    
}

final class HomeViewModel: RxViewModel, HomeViewModelInputs, HomeViewModelOutputs {
    
    private let _fetch = PublishRelay<Void>()
    func fetchInfo() {
        return self._fetch.accept(())
    }
    
    private let apiService = NetworkService()
    
    // MARK: Values
    private let _viewValue = BehaviorRelay<HomeViewResponse?>(value: nil)
    var valueChanged: Observable<HomeViewResponse?> {
        return self._viewValue.asObservable()
    }
    
    private let apiworker = NetworkService()
    
    override func bind() {
        
        self._fetch
            .withUnretained(self)
            .bind(onNext: { $0.0.getUserInfo() })
            .disposed(by: self.disposeBag)
    }
    
    private func getUserInfo() {
        
        guard let token = KeychainService.shared.loadToken() else { return }
        
        let url = AccountAPI.userInfo.url
        
        let headers: HTTPHeaders? = HTTPHeaders([FlUFFYAPI.Header.authFieldName: FlUFFYAPI.Header.auth(token).value])
        
        self.apiworker.performRequest(url: url, method: .get, parameters: nil as Empty?, headers: headers) { (result: Result<AccountResponse, Error>) in
            
            switch result {
            case .success(let response):
                print("Response:", response)
                
            case .failure(let error):
                print("Error:", error)
            }
        }
    }
}
