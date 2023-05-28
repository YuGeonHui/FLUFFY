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
    func getRequest<T: Decodable>(url: String, parameters: [String: Any]?, headers: HTTPHeaders?, completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(
            url,
            method: .get,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Post
    func postRequest<T: Decodable>(url: String, parameters: [String: Any]?, headers: HTTPHeaders?, completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(
            url,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: T.self) { response in
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
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Update
    func updateRequest<T: Encodable, U: Decodable>(url: String, parameters: T?, headers: HTTPHeaders?, completion: @escaping (Result<U, Error>) -> Void) {
        
        AF.request(
            url,
            method: .put,
            parameters: parameters as? Parameters,
            encoding: JSONEncoding.default,
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .responseDecodable(of: U.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
}





