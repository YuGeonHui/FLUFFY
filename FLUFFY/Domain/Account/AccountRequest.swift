//
//  AccountRequest.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/06.
//

import Foundation

struct AccountSignInRequest: Codable {
    let uuid: String
}

struct AccountSignUpRequest: Codable {
    let uuid: String
    let nickname: String
}
