//
//  AccountSignUpResponse.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/06.
//

import Foundation

struct AccountResponse: Codable {
    let token: String
}

struct AccountUserResponse: Codable {
    let point: String
}
