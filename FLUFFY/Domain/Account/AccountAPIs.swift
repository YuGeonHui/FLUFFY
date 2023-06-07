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
    case remove

    var url: String {
        
        switch self {
        case .signIn: return "\(FlUFFYAPI.baseURL)/api/account/signin"
        case .signUp: return "\(FlUFFYAPI.baseURL)/api/account/signup"
        case .userInfo: return "\(FlUFFYAPI.baseURL)/api/user/info"
        case .check: return "\(FlUFFYAPI.baseURL)/api/account/check"
            
            // 탈퇴 시, 토근도 지울 것!
        case .remove: return "\(FlUFFYAPI.baseURL)/api/user/secession"
        }
    }
}
