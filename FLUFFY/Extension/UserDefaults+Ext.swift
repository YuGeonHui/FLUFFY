//
//  UserDefaults+Ext.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import Foundation

extension UserDefaults {
    
    static func isFirstAppLauch() -> Bool {
        
        let firstLaunchFlag = "firstLaunchFlag"
        
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: firstLaunchFlag)
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: firstLaunchFlag)
            UserDefaults.standard.synchronize()
        }
        
        return isFirstLaunch
    }
}
