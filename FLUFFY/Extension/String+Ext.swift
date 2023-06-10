//
//  String+Ext.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/06/04.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a hh:mm"
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
    
}
