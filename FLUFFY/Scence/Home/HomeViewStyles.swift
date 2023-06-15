//
//  HomeViewStyles.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/10.
//

import UIKit
import SwiftRichString

extension FluffyHomeView {
    
    enum Metric {
        
        static let loginInset: UIEdgeInsets = UIEdgeInsets(top: 3, left: 11, bottom: 3, right: 11)
        
        static let topAnchor: CGFloat = 30
        
        enum NoLogin {
            
            static let titleAfter: CGFloat = 19
            static let descAfter: CGFloat = 42
            static let imageAfter: CGFloat = 35
            static let tagAfter: CGFloat = 12
        }
        
        enum Login {
            
            static let titleAfter: CGFloat = 11
            static let tagAfter: CGFloat = 12
            
            static let bottomAnchor: CGFloat = -97
        }
    }
    
    enum Color {
        static let background: UIColor = UIColor(hex: "f9f9f9")
        static let loginTag: UIColor = UIColor(hex: "89bfff")
    }
    
    enum Styles {
        
        static var title: Style = Style {
            $0.font = UIFont.pretendard(.bold, size: 24)
            $0.color = UIColor(hex: "2c2c2c")
            $0.alignment = .center
        }
        
        static let desc: Style = Style {
            $0.font = UIFont.pretendard(.medium, size: 15)
            $0.color = UIColor(hex: "2d2d2d")
            $0.minimumLineHeight = 26
            $0.maximumLineHeight = 26
            $0.alignment = .center
        }
        
        static let logIn: Style = Style {
            $0.font = UIFont.candyBean(.normal, size: 19)
            $0.color = UIColor(hex: "ffffff")
            $0.alignment = .center
        }
        
        static let logInDesc: Style = Style {
            $0.font = UIFont.pretendard(.semiBold, size: 14)
            $0.color = UIColor(hex: "89bfff")
            $0.alignment = .center
            
        }
    }
}
