//
//  ScheduleInfo.swift
//  FLUFFY
//
//  Created by 김강현 on 2023/06/08.
//

import Foundation

struct ScheduleInfo: Codable {
    let scheduleContent: String
    let scheduleDate, scheduleTime, stressStep: Int
    
    enum CodingKeys: String, CodingKey {
        case scheduleContent = "schedule_content"
        case scheduleDate = "schedule_date"
        case scheduleTime = "schedule_time"
        case stressStep = "stress_step"
    }
}


struct AllScheduleDate: Codable {
    let scheduleDate, id, stressStep, userID: Int
    let scheduleContent: String
    let scheduleTime: Int
    let createdTime: String
    
    enum CodingKeys: String, CodingKey {
        case scheduleDate = "schedule_date"
        case id
        case stressStep = "stress_step"
        case userID = "user_id"
        case scheduleContent = "schedule_content"
        case scheduleTime = "schedule_time"
        case createdTime = "created_time"
    }
}

struct UserScore: Codable {
    let userPoint: Double
    
    enum CodingKeys: String, CodingKey {
        case userPoint = "user_point"
    }
}


