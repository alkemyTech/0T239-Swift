//
//  SignUpViewModel.swift
//  SwiftTemplate
//
//  Created by Pablo Manzur on 25/06/2022.
//

import Foundation
import UIKit


protocol RegisterDelegate {
    func showSuccessMessage(newUserResponse: NewUserResponse)
    func showErrorAtRegister()
}


class SignUpViewModel {
    
    private var service: UsersService
    private var delegate: RegisterDelegate?
    
    init(service: UsersService, delegate: RegisterDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
    func register(user: NewUser) {
        self.service.addNewUser(user: user) { response in
            self.delegate?.showSuccessMessage(newUserResponse: response)
        } onError: {
            self.delegate?.showErrorAtRegister()
        }

    }
    
}

