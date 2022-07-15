//
//  UserManager.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 04-07-22.
//

import Foundation

protocol UserManagerProtocol {
    func saveUserToken(token: String)
    func containsThis(key: String) -> Bool
}

class UserManager: UserManagerProtocol {
    
    static let shared = UserManager()
    
    private init() {}
    
    private let defaults = UserDefaults.standard
    private var userToken: String = "" {
        didSet {
            setUserToken()
        }
    }
    
    private func setUserToken() {
        defaults.set(userToken, forKey: "userToken")
    }
    
    func saveUserToken(token: String) {
        userToken = token
    }
    
    func containsThis(key: String) -> Bool {
        defaults.object(forKey: key) != nil
    }
}
