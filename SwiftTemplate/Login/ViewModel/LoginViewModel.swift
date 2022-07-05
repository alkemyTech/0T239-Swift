//
//  LoginViewModel.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 29-06-22.
//

import Foundation

protocol LoginViewModelInterface {
    func getEmailLabelMessage(email: String, isValid: Bool) -> String
    func getPasswordLabelMessage(password: String, isValid: Bool) -> String
}

final class LoginViewModel: LoginViewModelInterface {
        
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
