//
//  EndpointDefinition.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 04-07-22.
//

import Foundation
import Alamofire

protocol EndpointDefinition {
    var baseURL: String { get }
    var path: String { get }
    var queryParams: [String: String] { get }
    var headers: [String: String] { get }
    var bodyParams: [String: String] { get }
    var method: HTTPMethod { get }
}

extension EndpointDefinition {
    var baseURL: String {
        return ConstantsURL.baseURL
    }
    
    var queryParams: [String: String] {
        return [:]
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    var bodyParams: [String: String] {
        return [:]
    }
}
