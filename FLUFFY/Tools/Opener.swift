//
//  Opener.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/31.
//

import UIKit

enum Opener {
    
    static func open(urlString: String, fallback: String? = nil) {
        
        guard let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: encoded) else {
            return
        }
        
        guard UIApplication.shared.canOpenURL(url) else {
            
            if let fbEncoded = fallback?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let fbUrl = URL(string: fbEncoded), UIApplication.shared.canOpenURL(fbUrl) {
                
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(fbUrl, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(fbUrl)
                }
            }
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: { opened in
                debugPrint("\(opened)")
            })
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
