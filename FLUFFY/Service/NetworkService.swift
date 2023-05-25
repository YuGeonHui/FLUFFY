//
//  NetworkService.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/25.
//

import Foundation
import Alamofire

struct NetworkService {
    
    
    // MARK: - GET
    func getRequest() {
        let url = "https://jsonplaceholder.typicode.com/todos/1"
        
        let header : HTTPHeaders = ["Content-Type":"application/json", "Accept":"application/json"]
        
        AF.request(
            url, // [주소]
            method: .get, // [전송 타입]
            parameters: nil, // [전송 데이터]
            encoding: JSONEncoding.default, // [인코딩 스타일]
            headers: header // [헤더 지정]
        )
        .validate(statusCode: 200..<300)
        .responseData { response in
            print(response)
        }
    }
    
    // MARK: - Post
    func postRequest() {
        let url = ""
        
        AF.request(
            url, // [주소]
            method: .post, // [전송 타입]
            parameters: nil, // [전송 데이터]
            encoding: JSONEncoding.default, // [인코딩 스타일]
            headers: nil // [헤더 지정]
        )
        .validate(statusCode: 200..<300)
        .responseData { response in
            switch response.result {
            case .success(let res):
                print("응답 코드 :: \(response.response?.statusCode ?? 0)")
                print("응답 데이터 :: \(String(data: res, encoding: .utf8) ?? "")")
            case .failure(let err):
                print("응답 코드 :: \(response.response?.statusCode ?? 0)")
                print("에 러 :: \(err.localizedDescription)")
                break
            }
        }
    }
    
    // MARK: - Delete
    func deleteRequest() {
        let url = ""
        
        AF.request(
            url,
            method: .delete,
            parameters: nil,
            encoding: JSONEncoding.default,
            headers: nil
        )
        .validate(statusCode: 200..<300)
        .responseData { response in
            switch response.result {
            case .success(let res):
                print(res)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}





