//
//  AccountAPIs.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/01.
//

import Foundation

enum AccountAPI {
    
    case signIn
    case signUp
    case userInfo
    
    var spec: APISpec {
        
        switch self {
        case .signIn:
            return APISpec(method: .post, url: "\(FlUPPYAPI.baseURL)/account/signin")
        case .signUp:
            return APISpec(method: .post, url: "\(FlUPPYAPI.baseURL)/account/signup")
        case .userInfo:
            return APISpec(method: .get, url: "\(FlUPPYAPI.baseURL)/user/info")
        }
    }
}
