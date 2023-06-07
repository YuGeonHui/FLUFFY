//
//  AccountSignUpResponse.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/06.
//

import Foundation

struct AccountResponse: Codable {
    let token: String
}

struct AccountUserResponse: Codable {
    
    let nickname: String?
    let point: Double?
    let dateStr: String?
    
    enum CodingKeys: String, CodingKey {
        case nickname = "user_nickname"
        case point = "user_point"
        case dateStr = "user_created_time"
    }
}

struct AccountRemoveResponse: Codable {
    let msg: String
}
