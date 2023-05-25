//
//  KeychainService.swift
//  FLUFFY
//
//  Created by geonhui Yu on 2023/05/25.
//

import Foundation
import Security

final class KeychainService {
    
    private enum Const {
        
        static let accessGroup = "SecuritySerivice"
        static let KEYCHAIN_TOKEN = "LOGIN_TOKEN"

        static let kSecClassValue = String(kSecClass)
        static let kSecAttrAccountValue = String(kSecAttrAccount)
        static let kSecValueDataValue = String(kSecValueData)
        static let kSecAttrServiceValue = String(kSecAttrService)
        static let kSecMatchLimitValue = String(kSecMatchLimit)
        static let kSecReturnDataValue = String(kSecReturnData)
        static let kSecAttrAccessibleValue = String(kSecAttrAccessible)
    }
    
    static let shared = KeychainService()
    
    private init() {}
    
    func saveToken(token: String) {
        return KeychainService.shared.save(Const.KEYCHAIN_TOKEN, token)
    }

    func loadToken() -> String? {
        return KeychainService.shared.load(Const.KEYCHAIN_TOKEN)
    }

    func isTokenValidate() -> Bool {
        
        guard let isValid = KeychainService.shared.load(Const.KEYCHAIN_TOKEN) else {
            return false
        }
        
        return true
    }

    func deleteToken() {
        return KeychainService.shared.delete(Const.KEYCHAIN_TOKEN)
    }
}

extension KeychainService {
    
    public func save(_ key: String, _ value: String) {
        var keychainQuery = self.getKeychainQuery(key)

        self.delete(key)

        if let value = try? NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false) {
            keychainQuery[Const.kSecValueDataValue] = value
        }

        let status: OSStatus = SecItemAdd(keychainQuery as CFDictionary, nil)
        debugPrint("save status: \(status)")
    }
    
    private func load(_ key: String) -> String? {
        var keychainQuery = self.getKeychainQuery(key)

        keychainQuery[Const.kSecReturnDataValue] = kCFBooleanTrue
        keychainQuery[Const.kSecMatchLimitValue] = kSecMatchLimitOne
        var result: AnyObject?
        let status: OSStatus = SecItemCopyMatching(keychainQuery as CFDictionary, &result)

        guard status == errSecSuccess else { print("처리실패. Status code \(status)"); return nil }
        guard let resultData = result as? Data else { print("로드 실패. \(status)"); return nil }
        guard let value = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSString.self, from: resultData) as String? else {
            return nil
        }
        return value
    }
    
    private func delete(_ key: String) {
        let keychainQuery = self.getKeychainQuery(key)

        let status = SecItemDelete(keychainQuery as CFDictionary)
        debugPrint("delete status: \(status)")
    }
    
    private func getKeychainQuery(_ key: String) -> [String: Any] {
        let keychainQuery: [String: Any] = [
            Const.kSecClassValue: kSecClassGenericPassword,
            Const.kSecAttrServiceValue: key,
            Const.kSecAttrAccountValue: key,
            Const.kSecAttrAccessibleValue: kSecAttrAccessibleAfterFirstUnlock
        ]
        return keychainQuery
    }
}
