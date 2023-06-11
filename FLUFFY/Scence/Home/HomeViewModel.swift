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

extension FluffyHomeView {
    
    final class ViewModel: RxViewModel {
        
        private let _fetch = PublishRelay<Void>()
        func fetchInfo() {
            return self._fetch.accept(())
        }
        
        private let apiService = NetworkService()
        
        // MARK: Values
        private let _viewValue = BehaviorRelay<ViewValue?>(value: nil)
        var valueChanged: Observable<ViewValue?> {
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
            
            self.apiworker.performRequest(url: url, method: .get, parameters: nil as Empty?, headers: headers) { (result: Result<AccountUserResponse, Error>) in
                
                switch result {
                case .success(let response):
                    
                    print("Response:", response)
                    
                    let status = self.getStatus(response.point)
                    let viewValue = ViewValue(nickname: response.nickname, status: status)
                    
                    self._viewValue.accept(viewValue)
                    UserDefaults.standard.userScore = response.point ?? 0.0
                    
                case .failure(let error):
                    print("Error:", error.localizedDescription)
                }
            }
        }
        
        private func getStatus(_ point: Double?) -> Status {
            
            guard let point else { return .unknow }
            
            switch point {
            case ..<0: return .unknow
            case 0...15: return .safe
            case 16...30: return .caution
            case 31...50: return .danger
            default: return .warning
            }
        }
    }
}
