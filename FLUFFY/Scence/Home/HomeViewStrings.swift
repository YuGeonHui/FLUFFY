//
//  HomeViewStrings.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/10.
//

import Foundation

extension String {
    
    enum Home {}
}

extension String.Home {

    static var title: String {
        return "만나서 반가워요!"
    }
    
    static var desc: String {
        return "당신만의 번아웃 예방 가이드, 플러피에요!\n저와 함께 슬기로운 일정관리를 시작해 볼까요?"
    }
    
    static var login: String {
        return "Log in >"
    }
    
    static var loginDesc: String {
        return "로그인하고 번아웃 예방하기"
    }
}
