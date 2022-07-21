//
//  NewsModel.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 20-07-22.
//

import Foundation

struct NewsModel {
    let succes: Bool
    let data: [News]
}

struct News {
    let name: String
    let content: String
    let image: String
}
