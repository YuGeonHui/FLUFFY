//
//  ScheduleRequest.swift
//  FLUFFY
//
//  Created by 김강현 on 2023/06/08.
//

import Foundation

struct ScheduleRequest: Codable {
    let scheduleContent: String
    let scheduleDate, scheduleTime, stressStep: Int
}
