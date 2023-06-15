//
//  UserDefaults+Ext.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import Foundation

let NICKNAME_KEY = "nickname_key"
let PUSH_TIME_KEY = "push_time_key"

extension UserDefaults {
    
    enum Const {
        static let NICKNAME_KEY = "nickname_key"
        static let PUSH_TIME_KEY = "push_time_key"
        
        static let kIsPermAgreed = "isPermAgreed"
        static let kIsUserScore = "IsUserScore"
        
        static let kIsPushHour = "isPushHour"
        static let kIsPushMinute = "isPushMinute"
    }
    
    static func isFirstAppLauch() -> Bool {
        
        let firstLaunchFlag = "firstLaunchFlag"
        
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: firstLaunchFlag)
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: firstLaunchFlag)
            UserDefaults.standard.synchronize()
        }
        
        return isFirstLaunch
    }
    
    var isPermAgreed: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Const.kIsPermAgreed)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Const.kIsPermAgreed)
            UserDefaults.standard.synchronize()
        }
    }
    
    var userScore: Double {
        get {
            return UserDefaults.standard.double(forKey: Const.kIsUserScore)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Const.kIsUserScore)
            UserDefaults.standard.synchronize()
        }
    }
    
    var pushHour: Int {
        get {
            return UserDefaults.standard.integer(forKey: Const.kIsPushHour)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Const.kIsPushHour)
            UserDefaults.standard.synchronize()
        }
    }
    
    var pushMinute: Int {
        get {
            return UserDefaults.standard.integer(forKey: Const.kIsPushMinute)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Const.kIsPushMinute)
            UserDefaults.standard.synchronize()
        }
    }
}
