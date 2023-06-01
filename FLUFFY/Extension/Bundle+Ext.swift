//
//  Bundle+Ext.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/01.
//

import Foundation

extension Bundle {
    
    var appVersion: String {
        
        guard let dict = self.infoDictionary else {
            return ""
        }
        
        if let version = dict["CFBundleShortVersionString"] as? String {
            return version
        } else {
            return ""
        }
    }
}
