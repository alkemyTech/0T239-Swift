//
//  MembersModel.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 18-07-22.
//

import Foundation

struct MembersModel {
    let success: Bool
    let data: [Member]
}

struct Member {
    let id: Int
    let name: String
    let image: String
    let description: String
    let largeDescription: String
}
