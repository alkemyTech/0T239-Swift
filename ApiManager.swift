//
//  ApiManager.swift
//  SwiftTemplate
//
//  Created by Pablo Manzur on 25/06/2022.
//

import Foundation
import Alamofire

final class ApiManager {
    
    static let shared = ApiManager()
    
    
    func addNewUser(url: String, parameters: NewUser, onCompletion: @escaping (Result<Data?, AFError>) -> Void) {
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default).validate().response {
            response in
            onCompletion(response.result)
        }
        
    }
    
}
