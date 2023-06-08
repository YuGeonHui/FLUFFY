//
//  SchedulerRequest.swift
//  FLUFFY
//
//  Created by 김강현 on 2023/06/08.
//

import Foundation

struct SchedulerRequest: Codable {
    let scheduleContent: String
    let scheduleDate, scheduleTime, stressStep: Int
}
