//
//  HomeViewValue.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/30.
//

import UIKit

struct HomeViewResponse: Equatable, Codable {

    var nickname: String?
    var characterInfo: Character?
    
    struct ViewValue {
        
        var nickname: String?
        var status: UIImage?
        var character: UIImage?
        var message: String?
    }
}
