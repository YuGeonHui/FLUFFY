//
//  Character.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import UIKit

enum Character: Equatable, CaseIterable, Codable {
    
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
    
    var message: String {
        
        switch self {
        case .unknow: return "아무이상 없음"
        case .safe: return "안전한 상태"
        case .caution: return "주의 상태"
        case .warning: return "경고 상태"
        case .danger: return "위험 상태"
        }
    }
    
    var icon: UIImage? {
        
        switch self {
        case .unknow: return nil
        case .safe: return UIImage(named: "")
        case .caution: return UIImage(named: "")
        case .warning: return UIImage(named: "")
        case .danger: return UIImage(named: "")
        }
    }
}
