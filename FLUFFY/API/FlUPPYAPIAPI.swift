//
//  FluppyAPI.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/26.
//

import Foundation
 
enum FlUPPYAPI {
    
    static let baseURL: String = "54.180.2.148:8000"
    
    enum Header: APIHeader {
        
        static let authFieldName: String = "Authorization"
        
        case auth(String)
        case contentMulti
        
        var key: String {
            
            switch self {
            case .auth: return FlUPPYAPI.Header.authFieldName
            case .contentMulti: return "Content-Type"
            }
        }
        
        var value: String {
            
            switch self {
            case .auth(let value): return "Bearer \(value)"
            case .contentMulti:return "multipart/form-data; boundary=\(APIConst.boundary)"
            }
        }
    }
}
