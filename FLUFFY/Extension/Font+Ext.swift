//
//  Font+Ext.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/28.
//

import UIKit

extension UIFont {
    
    enum Pretendard {
        
        case bold
        case extraBold
        case medium
        case semiBold
        case regular
        
        var value: String {
            switch self {
            case .bold:
                return "Pretendard-Bold"
            case .medium:
                return "Pretendard-Medium"
            case .semiBold:
                return "Pretendard-SemiBold"
            case .extraBold:
                return "Pretendard-ExtraBold"
            case .regular:
                return "Pretendard-Regular"
            }
        }
    }
    
    static func pretendard(_ type: Pretendard, size: CGFloat) -> UIFont {
        return UIFont(name: type.value, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

extension UIFont {
    
    enum CandyBean {
        
        case normal
        
        var value: String {
            
            switch self {
            case .normal: return "Candy Beans"
            }
        }
    }
    
    static func candyBean(_ type: CandyBean, size: CGFloat) -> UIFont {
        return UIFont(name: type.value, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
