//
//  HomeViewValue.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/30.
//

import UIKit

struct HomeViewResponse: Equatable, Codable {
    
    var nickname: String?
    var score: Int?
    var createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        
        case nickname = "user_nickname"
        case score = "user_point"
        case createdAt = "user_created_time"
    }
}

extension FluffyHomeView: Equatable {
    
    struct ViewValue {
        
        let nickname: String?
        let status: Status
    }
}
