//
//  LoginViewModel.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 29-06-22.
//

import Foundation

final class LoginViewModel {
    
    weak var view: LoginViewProtocol?
    
    private var isValidEmail = false
    private var isValidPassword = false
    
    func validateEmail(email: String) {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        isValidEmail = NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
        updateView()
    }
    
    func validatePassword(password: String) {
        isValidPassword = password.count >= 8
        updateView()
    }
    
    private func updateView() {
        view?.enableLoginButton(show: isValidEmail && isValidPassword)
        view?.showEmailObligatoryField(show: isValidEmail)
        view?.showPasswordObligatoryField(show: isValidPassword)
    }
}
