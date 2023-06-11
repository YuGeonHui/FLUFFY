//
//  MyPageViewStyles.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/11.
//

import UIKit
import SwiftRichString

extension FluffyMyPageView {
    
    enum Metric {
        
        static let loginInset: UIEdgeInsets = UIEdgeInsets(top: 3, left: 8, bottom: 3, right: 8)
        
        static var leadingAnchor: CGFloat = 20
        
        static var trailingAnchor: CGFloat = -20
        
        static var topAnchor: CGFloat = 26
        
        static var iconBefore: CGFloat = 4
        
        static var titleAfter: CGFloat = 18
        
        static var tagAfter: CGFloat = 11
        
        static var descAfter: CGFloat = 19
        
        static var dividerAfter: CGFloat = 27
        
        static var stackSpacing: CGFloat = 20
    }
    
    enum Color {
        
        static var background: UIColor = UIColor(hex: "f9f9f9")
        
        static let loginTag: UIColor = UIColor(hex: "89bfff")
    }
    
    enum Styles {
        
        static var title: Style = Style {
            $0.font = UIFont.pretendard(.bold, size: 25)
            $0.color = UIColor(hex: "1f1f1f")
        }
        
        static let status: Style = Style {
            $0.font = UIFont.candyBean(.normal, size: 15)
            $0.color = UIColor(hex: "ffffff")
        }
        
        static let loginDesc: Style = Style {
            $0.font = UIFont.pretendard(.semiBold, size: 14)
            $0.color = UIColor(hex: "89bfff")
        }
        
        static let goodDesc: Style = Style {
            $0.font = UIFont.pretendard(.semiBold, size: 14)
            $0.color = UIColor(hex: "19c8ff")
        }
    }
}
