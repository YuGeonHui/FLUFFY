//
//  API.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import Foundation
import Alamofire

protocol API {
    var spec: APISpec { get }
}

enum APIConst {
    static let boundary = UUID().uuidString
}

// MARK: API Header Protocol
protocol APIHeader {
    var key: String { get }
    var value: String { get }
}

// MARK: API Prameter Protocol
protocol APIParameter {
    var key: String { get }
    var value: Any? { get }
}

// MARK: API Specification
struct APISpec {
    let method: HTTPMethod
    let url: String
    let isAuthMandatory: Bool
    
    init(method: HTTPMethod, url: String, isAuthMandatory: Bool? = false) {
        self.method = method
        self.url = url
        self.isAuthMandatory = isAuthMandatory!
    }
}
