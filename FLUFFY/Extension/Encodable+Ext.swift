//
//  Encodable+Ext.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import Foundation

extension Encodable {
    
    var dictionary: [String: String]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: String]}
    }
}
