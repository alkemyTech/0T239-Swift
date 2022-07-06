//
//  UserModel.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 04-07-22.
//

import Foundation

struct UserModel: Codable {
    let success: Bool
    let data: DataClass
    let message: String
}
