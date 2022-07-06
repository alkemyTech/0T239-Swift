//
//  CommonViewModel.swift
//  SwiftTemplate
//
//  Created by Jose on 04/07/2022.
//

import Foundation

protocol ValidationInterface {
    func validateEmail(email: String) -> Bool
    func validatePassword(password: String) -> Bool
}

final class ValidationViewModel: ValidationInterface {
    
    func validateEmail(email: String) -> Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
    }
    
    func validatePassword(password: String) -> Bool {
        let pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{8,8}"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: password)
    }
}
