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
    case check

    var url: String {
        
        switch self {
        case .signIn: return "\(FlUFFYAPI.baseURL)/api/account/signin"
        case .signUp: return "\(FlUFFYAPI.baseURL)/api/account/signup"
        case .userInfo: return "\(FlUFFYAPI.baseURL)/api/user/info"
        case .check: return "\(FlUFFYAPI.baseURL)/api/account/check"
        }
    }
}
