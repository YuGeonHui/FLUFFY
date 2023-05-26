//
//  API.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import Foundation
import Alamofire

// MARK: API Constants
enum APIConst {
    static let boundary = UUID().uuidString
}

// MARK: API Header Protocol
protocol APIHeader {
    var key: String { get }
    var value: String { get }
}

// MARK: API Prameter Protocol
protocol APIParameter {
    var key: String { get }
    var value: Any? { get }
}
