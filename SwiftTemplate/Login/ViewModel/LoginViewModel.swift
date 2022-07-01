//
//  LoginViewModel.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 29-06-22.
//

import Foundation

protocol LoginViewModelInterface {
    func validateEmail(email: String)
    func validatePassword(password: String)
}

final class LoginViewModel: LoginViewModelInterface {
    
    weak var delegate: LoginViewDelegate?
    
    private var isValidEmail = false
    private var isValidPassword = false
    private var emailLabelMessage: String?
    private var passwordLabelMessage: String?
    
    func validateEmail(email: String) {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        isValidEmail = NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
        emailLabelMessage = calculateEmailLabelMessage(email: email)
        delegate?.showEmailObligatoryField(show: isValidEmail, message: emailLabelMessage)
        delegate?.enableLoginButton(show: isValidEmail && isValidPassword)
    }
    
    func validatePassword(password: String) {
        let pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{8,8}"
        isValidPassword = NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: password)
        passwordLabelMessage = calculatePasswordLabelMessage(password: password)
        delegate?.showPasswordObligatoryField(show: isValidPassword, message: passwordLabelMessage)
        delegate?.enableLoginButton(show: isValidEmail && isValidPassword)
    }
    
    private func calculateEmailLabelMessage(email: String) -> String? {
        if email.isEmpty {
            return "    *Campo obligatorio"
        } else if isValidEmail {
            return "Email válido"
        } else {
            return "Formato de email incorrecto"
        }
    }
    
    private func calculatePasswordLabelMessage(password: String) -> String? {
        if password.isEmpty {
            return "    *Campo obligatorio"
        } else if isValidPassword {
            return "Contraseña válida"
        } else {
            return "La contraseña debe contener 8 dígitos, al menos un carácter especial, una mayúscula, una minúscula y un número"
        }
    }
}
