//
//  LoginViewModel.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 29-06-22.
//

import Foundation
import UIKit

protocol LoginViewModelInterface {
    func getEmailLabelMessage(email: String, isValid: Bool) -> String
    func getPasswordLabelMessage(password: String, isValid: Bool) -> String
    func loginUser(email: String, password: String, from vc: UIViewController)
    func navigateToSignUp(navigationController: UINavigationController)
}

final class LoginViewModel: LoginViewModelInterface {
    
    private let loginRepository: LoginRepositoryProtocol
    private let userManager: UserManagerProtocol
    private let validationViewModel: ValidationInterface
    
    init(loginRepository: LoginRepositoryProtocol,
         userManager: UserManagerProtocol,
         validationViewModel: ValidationInterface = ValidationViewModel()
    ) {
        self.loginRepository = loginRepository
        self.userManager = userManager
        self.validationViewModel = validationViewModel
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
    
    func loginUser(email: String, password: String, from vc: UIViewController) {
        vc.showSpinner()
        Task {
            do {
                let login = try await loginRepository.loginUser(email: email, password: password)
                let token = login.data.token
                userManager.saveUserToken(token: token)
                
                guard let navigationController = await vc.navigationController else { return }
                navigateToHome(navigationController: navigationController)
                await vc.removeSpinner()
            } catch {
                print("Error")
            }
        }
    }
    
    func navigateToSignUp(navigationController: UINavigationController) {
        let signUpViewModel = SignUpViewModel(service: UsersService())
        let signUpViewController = SignUpViewController(signupviewmodel: signUpViewModel)
        navigationController.pushViewController(signUpViewController, animated: true)
    }
    
    private func navigateToHome(navigationController: UINavigationController) {
        let dropDownMenuRepository = DropDownMenuRepository()
        let dropDownMenuViewModel = DropDownMenuViewModel(repository: dropDownMenuRepository)
        
        let newsRepository = NewsRepository()
        let newsViewModel = NewsViewModel(repository: newsRepository)
        let homeViewModel = HomeViewModel(dropDownMenuViewModel: dropDownMenuViewModel, newsViewModel: newsViewModel)
        
        let membersRepository = MembersRepository()
        let membersViewModel = MembersViewModel(repository: membersRepository)
        
        let homeViewController = HomeViewController(viewModel: homeViewModel, membersViewModel: membersViewModel)
        
        DispatchQueue.main.async {
            navigationController.setViewControllers([homeViewController], animated: true)
        }
    }
}

extension LoginViewModel: ValidationInterface {
    func validateEmail(email: String) -> Bool {
        return self.validationViewModel.validateEmail(email: email)
    }
    
    func validatePassword(password: String) -> Bool {
        return validationViewModel.validatePassword(password: password)
    }
}
