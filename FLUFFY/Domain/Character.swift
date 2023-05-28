//
//  Character.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import Foundation

enum Character {
    
    case unknow
    case safe
    case caution
    case warning
    case danger
    
    var localizable: String {
        
        switch self {
        case .unknow: return ""
        case .safe: return "안전"
        case .caution: return "주의"
        case .warning: return "경고"
        case .danger: return "위험"
        }
    }
}
