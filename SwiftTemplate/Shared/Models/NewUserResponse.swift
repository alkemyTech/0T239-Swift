//
//  NewUserResponse.swift
//  SwiftTemplate
//
//  Created by Pablo Manzur on 25/06/2022.
//

import Foundation


struct NewUserResponse: Codable {
    let success: Bool
    let data: DataClass
    let message: String
}

// MARK: - DataClass
struct DataClass: Codable {
    let user: User
    let token: String
}

// MARK: - User
struct User: Codable {
    let name, email, password: String
    let roleID: Int?
    let updatedAt, createdAt: String?
    let id: Int?
    
    
    enum CodingKeys: String, CodingKey {
           case name, email, password
           case roleID = "role_id"
           case updatedAt = "updated_at"
           case createdAt = "created_at"
           case id
       }

}
