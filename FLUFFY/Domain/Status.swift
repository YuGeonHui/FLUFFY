//
//  Status.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import UIKit

enum Status: Equatable, CaseIterable, Codable {
    
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
    
    var desc: String {
        
        switch self {
        case .unknow: return ""
        case .safe: return "적절한 스트레스가 도움이 되는 상태"
        case .caution: return "일상 생활에 지장은 없지만, 관리가 필요한 상태"
        case .warning: return "스트레스가 쌓여 예민하고 지친 상태"
        case .danger: return "무기력하고 의욕이 사라진 상태"
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
    
    var character: UIImage? {
        
        switch self {
        case .unknow: return UIImage(named: "")
        case .safe: return UIImage(named: "")
        case .caution: return UIImage(named: "")
        case .warning: return UIImage(named: "")
        case .danger: return UIImage(named: "")
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
    
    var statusBar: UIImage? {
        
        switch self {
        case .unknow: return UIImage(named: "")
        case .safe:  return UIImage(named: "")
        case .caution:  return UIImage(named: "")
        case .warning: return UIImage(named: "")
        case .danger: return UIImage(named: "")
        }
    }
    
    var statusBarSize: CGSize {
        
        switch self {
        case .unknow: return CGSize(width: 0, height: 0)
        case .safe: return CGSize(width: 0, height: 0)
        case .caution: return CGSize(width: 0, height: 0)
        case .warning: return CGSize(width: 0, height: 0)
        case .danger: return CGSize(width: 0, height: 0)
        }
    }
}
