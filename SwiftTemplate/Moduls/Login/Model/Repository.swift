//
//  Repository.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 01-07-22.
//

import Foundation

protocol LoginRepositoryProtocol: AnyObject {
    func loginUser(email: String, password: String) async throws -> UserModel
}

class LoginRepository: LoginRepositoryProtocol {
    
    let api = RestApi()
    
    func loginUser(email: String, password: String) async throws -> UserModel {
        let endpoint = LoginEndpoint(email: email, password: password)
        return try await api.request(endpoint: endpoint)
    }
}
