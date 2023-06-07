//
//  UserInfo.swift
//  FLUFFY
//
//  Created by 김강현 on 2023/06/07.
//

import Foundation

struct UserInfo: Decodable {
    let userNickname: String?
    let userPoint: Double
    let userCreatedTime: String
    
    enum CodingKeys: String, CodingKey {
        case userNickname = "user_nickname"
        case userPoint = "user_point"
        case userCreatedTime = "user_created_time"
    }
}
