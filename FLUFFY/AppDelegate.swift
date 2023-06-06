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
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                self.scheduleLocalNotification()
            }
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
      
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
}

extension AppDelegate {
    
    func scheduleLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "오늘 하루 고생하셨어요 :)"
        content.body = "스트레스 지수가 변경 된 일정은 없는지 확인 해보세요!"
        content.sound = UNNotificationSound.default
        
        if let imageURL = Bundle.main.url(forResource: "fluffy_logo", withExtension: "png") {
            let attachment = try? UNNotificationAttachment(identifier: "imageAttachment", url: imageURL, options: nil)
            if let attachment = attachment {
                content.attachments = [attachment]
            }
        }
        
        var dateComponents = DateComponents()
        dateComponents.hour = 22
        dateComponents.minute = 00
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("로컬 알림 예약 실패: \(error)")
            } else {
                print("로컬 알림 예약 성공")
            }
        }
    }
}
