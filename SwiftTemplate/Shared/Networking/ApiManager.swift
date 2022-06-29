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
    
    
    func post <T: Encodable> (url: String, parameters: T , onCompletion: @escaping (Result<Data?, AFError>) -> Void) {
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default).validate().response {
            response in
            onCompletion(response.result)
        }
        
    }
    
}
