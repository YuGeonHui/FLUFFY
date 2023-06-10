//
//  AppDelegate.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK: 애플로그인
        self.appleApp(application, didFinishLauchingWithOptions: launchOptions)
        
        
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//        let center = UNUserNotificationCenter.current()
//        center.delegate = self
//        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
//            print(granted, error)
//        }
//
//        return true
//    }
    
}

//extension AppDelegate: UNUserNotificationCenterDelegate {
//    // foreground에서 시스템 푸시를 수신했을 때 해당 메소드가 호출
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.sound, .badge, .banner])
//    }
//}


