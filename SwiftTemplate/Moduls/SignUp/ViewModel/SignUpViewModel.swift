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

protocol SignUpViewModelInterface {
    func getEmailLabelMessage(email: String, isValid: Bool) -> String
    func getPasswordLabelMessage(password: String, isValid: Bool) -> String
    func register(user: NewUser)
}


class SignUpViewModel {
        
    init(service: UsersService,
         validationViewModel: ValidationInterface = ValidationViewModel()) {
        self.service = service
        self.validationViewModel = validationViewModel
    }
    
    private var service: UsersService
    let validationViewModel: ValidationInterface
    weak var delegate: RegisterDelegate?
    
}

extension SignUpViewModel: SignUpViewModelInterface {

    func register(user: NewUser) {
        self.service.addNewUser(user: user) { response in
            self.delegate?.registerNewUserSuccess(newUserResponse: response)
            
        } onError: { errorDescription in
            self.delegate?.registerNewUserError(errorDescription: errorDescription)
        }
    }
    
    func getEmailLabelMessage(email: String, isValid: Bool) -> String {
        if email.isEmpty {
            return "    *Campo obligatorio"
        } else if isValid {
            return "Email válido"
        } else {
            return "Formato de email incorrecto"
        }
    }
    
    func getPasswordLabelMessage(password: String, isValid: Bool) -> String {
        if password.isEmpty {
           return "    *Campo obligatorio"
        } else if isValid {
            return "Contraseña válida"
        } else {
            return "La contraseña debe contener 8 dígitos, al menos un carácter especial, una mayúscula, una minúscula y un número"
        }
    }
}

extension SignUpViewModel: ValidationInterface {
    func validateEmail(email: String) -> Bool {
        return validationViewModel.validateEmail(email: email)
    }
    
    func validatePassword(password: String) -> Bool {
        return validationViewModel.validatePassword(password: password)
    }
}