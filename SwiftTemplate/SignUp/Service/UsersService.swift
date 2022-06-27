//
//  UsersService.swift
//  SwiftTemplate
//
//  Created by Pablo Manzur on 25/06/2022.
//

import Foundation

class UsersService {
    
    func addNewUser(user: NewUser, onComplete: @escaping (NewUserResponse) -> Void, onError: @escaping () -> Void) {
        
        let url = Constants().newUsersURL
        
        ApiManager.shared.addNewUser(url: url, parameters: user) { response in
            switch response {
                case .success(let data):
                    do {
                        if let data = data {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let registerResponse = try decoder.decode(NewUserResponse.self, from: data)
                            onComplete(registerResponse)
                        } else {
                            onError()
                        }
                        
                    } catch  {
                        onError()
                        print(error)
                    }
                case .failure(_):
                    onError()
            }
        }
    }
}
