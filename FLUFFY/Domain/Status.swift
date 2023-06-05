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
        case .unknow: return ""
        case .safe: return "스트레스 관리를 잘 하고 계시네요!\n현재 상태를 유지하도록 꾸준히 노력해봐요."
        case .caution: return "일과 휴식의 경계가 아슬아슬해요!\n적절한 휴식시기를 놓치지 않도록 주의해주세요."
        case .warning: return "동동님의 상태가 좋지 않아요!\n회복을 위해 휴식을 취하시는 것을 추천드려요."
        case .danger: return "동동님, 이제는 정말 위험할 수 있어요!\n이번 주에는 동동님을 위한 시간이 꼭 필요해요"
        }
    }
    
    var character: UIImage? {
        
        switch self {
        case .unknow: return UIImage(named: "")
        case .safe: return UIImage(named: "character_good")
        case .caution: return UIImage(named: "character_caution")
        case .warning: return UIImage(named: "character_warning")
        case .danger: return UIImage(named: "character_danger")
        }
    }
    
    var icon: UIImage? {
        
        switch self {
        case .unknow: return nil
        case .safe: return UIImage(named: "goodIcon")
        case .caution: return UIImage(named: "cautionIcon")
        case .warning: return UIImage(named: "warningIcon")
        case .danger: return UIImage(named: "dangerIcon")
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
