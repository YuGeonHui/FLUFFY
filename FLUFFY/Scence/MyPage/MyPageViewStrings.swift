//
//  MyPageViewStrings.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/11.
//

import Foundation

extension String {
    
    enum MyPage {
        
        enum PushSetting {}
        enum Notice {}
        enum Inquire {}
        enum Term {}
        enum Version {}
    }
}

extension String.MyPage {
    
    static var title: String {
        return "환영해요!"
    }
    
    static var login: String {
        return "Log in >"
    }
    
    static var loginDesc: String {
        return "로그인하고 번아웃 예방하기"
    }
    
    static var good: String {
        return "GOOD"
    }
    
    static var goodDesc: String {
        return "적절한 스트레스가 도움이 되는 상태"
    }
}

extension String.MyPage.PushSetting {
    
    static var title: String {
        return "푸시 알림 시간 변경"
    }
}

extension String.MyPage.Notice {
    
    static var title: String {
        return "공지사항"
    }
}

extension String.MyPage.Inquire {
    
    static var title: String {
        return "문의하기"
    }
}

extension String.MyPage.Term {
    
    static var title: String {
        return "이용약관"
    }
}

extension String.MyPage.Version {
    
    static var title: String {
        return "버전정보"
    }
}
