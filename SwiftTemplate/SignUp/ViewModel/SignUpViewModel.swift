//
//  SignUpViewModel.swift
//  SwiftTemplate
//
//  Created by Pablo Manzur on 25/06/2022.
//

import Foundation
import UIKit


protocol RegisterDelegate: AnyObject {
    func registerNewUserSuccess(newUserResponse: NewUserResponse)
    func registerNewUserError(errorDescription: String)
}


class SignUpViewModel {

    private var service: UsersService
    weak var delegate: RegisterDelegate?
    
    init(service: UsersService) {
        self.service = service
    }
    
    func register(user: NewUser) {
        self.service.addNewUser(user: user) { response in
            self.delegate?.registerNewUserSuccess(newUserResponse: response)
            
        } onError: { errorDescription in
            self.delegate?.registerNewUserError(errorDescription: errorDescription)
        }
    }
    
}

