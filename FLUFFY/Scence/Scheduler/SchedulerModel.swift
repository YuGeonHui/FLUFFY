//
//  SchedulerModel.swift
//  FLUFFY
//
//  Created by 김강현 on 2023/06/06.
//

import Foundation
import Alamofire


struct User {
    
    private let networkService = NetworkService()
    
    private let url = "http://54.180.2.148:8000/api/user/info"
    
    private let headers: HTTPHeaders = [
        "Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MDA4MTQ5NTAsImlhdCI6MTY4NTI2Mjk1MCwic3ViIjoidGVzdCJ9._DA6jFmamgQnlgTAnx6dtnLkmjJigIabsxOl83GAj8Y",
        "Content-Type": "application/json"
    ]
    
    func getUserName(_ viewController: ScheudlerViewController) {
        networkService.getRequest(url: url, method: .get, headers: headers) { (result: Result<UserInfo, Error>) in
            switch result {
            case .success(let response):
                // 성공적으로 응답 받았을 때의 처리
                print(response)
                viewController.didSuccess(response)
            case .failure(let error):
                // 요청 실패 또는 응답 처리 오류가 발생했을 때의 처리
                print(error)
            }
        }
    }
    
}
