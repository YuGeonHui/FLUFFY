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
    func getRequest<T: Decodable>(url: String, parameters: [String: Any]?, headers: [String: String]?, completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(
            url, // [주소]
            method: .get, // [전송 타입]
            parameters: parameters, // [전송 데이터]
            encoding: JSONEncoding.default, // [인코딩 스타일]
            headers: headers // [헤더 지정]
        )
        .validate(statusCode: 200..<300)
        .responseData { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Post
    func postRequest<T: Decodable>(url: String, parameters: [String: Any]?, headers: [String: String]?, completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(
            url, // [주소]
            method: .post, // [전송 타입]
            parameters: parameters, // [전송 데이터]
            encoding: JSONEncoding.default, // [인코딩 스타일]
            headers: headers // [헤더 지정]
        )
        .validate(statusCode: 200..<300)
        .responseData { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Delete
    func deleteRequest<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(
            url,
            method: .delete
        )
        .validate(statusCode: 200..<300)
        .responseData { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}





