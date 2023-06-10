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
    
    private let url = "http://54.180.2.148:8000/"
    
    
    
//    private let headers: HTTPHeaders = [
//        "Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MDA4MTQ5NTAsImlhdCI6MTY4NTI2Mjk1MCwic3ViIjoidGVzdCJ9._DA6jFmamgQnlgTAnx6dtnLkmjJigIabsxOl83GAj8Y",
//        "Content-Type": "application/json"
//    ]
//
//    private let postHeaders: HTTPHeaders = [
//        "Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3MDE3Mzc0NjIsImlhdCI6MTY4NjE4NTQ2Miwic3ViIjoiYWJjIn0.aGUyz8axiTLXv89Cj3oY0m_XPVSbm5huZ9iW4fsOw20",
//        "Content-Type": "application/json"
//    ]
    
    func getUserName(_ viewController: ScheudlerViewController) {
        
        guard let token = KeychainService.shared.loadToken() else {return}
        let headers: HTTPHeaders? = HTTPHeaders([FlUFFYAPI.Header.authFieldName: FlUFFYAPI.Header.auth(token).value])
        
        networkService.getRequest(url: url + "api/user/info", method: .get, headers: headers) { (result: Result<UserInfo, Error>) in
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
    
    func getAllSchedule(selectedDate: String, _ viewController: ScheudlerViewController) {
        
        let url = url + "api/scheduling/" + "\(selectedDate)"
        
        guard let token = KeychainService.shared.loadToken() else {return}
        let headers: HTTPHeaders? = HTTPHeaders([FlUFFYAPI.Header.authFieldName: FlUFFYAPI.Header.auth(token).value])
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: [AllScheduleDate].self) { response in
            switch response.result {
            case .success(let response): // 응답이 성공적으로 받아졌을 때
                // schedules는 [AllScheduleDate] 타입으로 디코딩된 배열입니다.
                // 받은 데이터를 사용하여 작업을 수행할 수 있습니다.
                viewController.scheduleGetDidSuccess(response)
                
            case .failure(let error): // 요청이 실패했을 때
                print("요청 실패: \(error)")
            }
        }
    }
    
    func getEditSchedule(selectedDate: String, _ viewController: EditModalViewController) {
        
        guard let token = KeychainService.shared.loadToken() else {return}
        let headers: HTTPHeaders? = HTTPHeaders([FlUFFYAPI.Header.authFieldName: FlUFFYAPI.Header.auth(token).value])
        
        let url = url + "api/scheduling/" + "\(selectedDate)"
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: [AllScheduleDate].self) { response in
            switch response.result {
            case .success(let response): // 응답이 성공적으로 받아졌을 때
                // schedules는 [AllScheduleDate] 타입으로 디코딩된 배열입니다.
                // 받은 데이터를 사용하여 작업을 수행할 수 있습니다.
                viewController.scheduleGetSuccess(response)
                
            case .failure(let error): // 요청이 실패했을 때
                print("get edit 요청 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func getDetailSchedule(id: Int, _ viewController: EditModalViewController) {
        
        guard let token = KeychainService.shared.loadToken() else {return}
        let headers: HTTPHeaders? = HTTPHeaders([FlUFFYAPI.Header.authFieldName: FlUFFYAPI.Header.auth(token).value])
        
        let url = url + "api/scheduling/detail/" + "\(id)"
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: AllScheduleDate.self) { response in
            switch response.result {
            case .success(let response):
                viewController.updateSchedule(response)
            case .failure(let error):
                print("get detail 요청 실패: \(error.localizedDescription)")
            }
        }
        
    }
    
    func deleteSchedule(id: Int, _ viewController: ScheudlerViewController) {
        
        let url = url + "api/scheduling"
        let parameters = [ "schedule_id" : id]
        
        guard let token = KeychainService.shared.loadToken() else {return}
        let headers: HTTPHeaders? = HTTPHeaders([FlUFFYAPI.Header.authFieldName: FlUFFYAPI.Header.auth(token).value])
        
        AF.request(url, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: UserScore.self) { response in
                switch response.result {
                case .success(let response):
                    viewController.deleteScheduleSuccess(response)
                    UserDefaults.standard.set(response.userPoint, forKey: "userScore")
                case .failure(let err):
                    print("요청 실패: \(err.localizedDescription)")
                }
            }
    }
}




