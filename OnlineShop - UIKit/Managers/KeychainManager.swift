//
//  KeychainManager.swift
//  OnlineShop - UIKit
//
//  Created by Luka Podrug on 17.01.2024..
//

import Foundation

enum KeychainError: Error {
    case duplicate
    case notFound
    case unknown
}

extension KeychainError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .duplicate:
                return NSLocalizedString("Duplicate item", comment: "")
            case .notFound:
                return NSLocalizedString("Item not found", comment: "")
            case .unknown:
                return NSLocalizedString("Unknown error", comment: "")
        }
    }
}

class KeychainManager {
    static let shared: KeychainManager = KeychainManager()
    
    func save(type: CFString, service: String, account: String, data: Data, completion: @escaping (Result<String, KeychainError>) -> Void) {
        let query: [String: AnyObject] = [
            kSecClass as String: type,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: data as AnyObject
        ]
        
        let status: OSStatus = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            completion(.failure(.duplicate))
            return
        }
        
        if status != errSecSuccess {
            completion(.failure(.unknown))
            return
        }
        
        completion(.success("Item saved"))
    }
    
    func get(type: CFString, service: String, account: String, completion: @escaping (Result<Data, KeychainError>) -> Void) {
        let query: [String: AnyObject] = [
            kSecClass as String: type,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecItemNotFound {
            completion(.failure(.notFound))
            return
        }
        
        else if status != errSecSuccess {
            completion(.failure(.unknown))
            return
        }
        
        completion(.success(result as! Data))
    }
    
    func remove(type: CFString, service: String, account: String, completion: @escaping (Result<String, KeychainError>) -> Void) {
        let query: [String: AnyObject] = [
            kSecClass as String: type,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject
        ]
        
        let status: OSStatus = SecItemDelete(query as CFDictionary)
        
        if status != errSecSuccess {
            completion(.failure(.unknown))
            return
        }
        
        completion(.success("Item removed"))
    }
}
