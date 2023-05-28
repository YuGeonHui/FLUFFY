//
//  NetworkService.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/25.
//

import Foundation
import Alamofire

struct NetworkService {
    
    // MARK: - Perform Request
    func performRequest<T: Decodable, U: Encodable>(url: String, method: HTTPMethod, parameters: U?, headers: HTTPHeaders?, completion: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(
            url,
            method: method,
            parameters: parameters as? Parameters,
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
}






