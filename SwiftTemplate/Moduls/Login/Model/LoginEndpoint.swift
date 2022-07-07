//
//  LoginEndpoint.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 04-07-22.
//

import Foundation
import Alamofire

struct LoginEndpoint: EndpointDefinition {
    
    let email: String
    let password: String
    
    var path: String {
        return "login"
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var bodyParams: [String : String] {
        return ["email": email,
                "password": password]
    }
}
