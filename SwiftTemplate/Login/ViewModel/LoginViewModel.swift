//
//  LoginViewModel.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 29-06-22.
//

import Foundation
import UIKit

protocol LoginViewModelInterface {
    func validateEmail(email: String) -> Bool
    func validatePassword(password: String) -> Bool
    func getEmailLabelMessage(email: String, isValid: Bool) -> String
    func getPasswordLabelMessage(password: String, isValid: Bool) -> String
    func loginUser(email: String, password: String)
    func navigateToSignUp(navigationController: UINavigationController)
}

final class LoginViewModel: LoginViewModelInterface {
    
    private let loginRepository: LoginRepositoryProtocol
    private let userManager: UserManagerProtocol
    
    init(loginRepository: LoginRepositoryProtocol, userManager: UserManagerProtocol) {
        self.loginRepository = loginRepository
        self.userManager = userManager
    }
    
    func validateEmail(email: String) -> Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
    }
    
    func validatePassword(password: String) -> Bool {
        let pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{8,8}"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: password)
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
    
    func loginUser(email: String, password: String) {
        Task {
            do {
                let login = try await loginRepository.loginUser(email: email, password: password)
                let token = login.data.token
                userManager.saveUserToken(token: token)
            } catch {
                print("Error")
            }
        }
    }
    
    func navigateToSignUp(navigationController: UINavigationController) {
        let signUpViewController = SignUpViewController()
        navigationController.pushViewController(signUpViewController, animated: true)
    }
}
