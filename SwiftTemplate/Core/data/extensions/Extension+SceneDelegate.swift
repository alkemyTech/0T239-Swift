//
//  Extension+SceneDelegate.swift
//  SwiftTemplate
//
//  Created by Pablo Manzur on 16/07/2022.
//

import Foundation
import UIKit

protocol CheckIfTokenWasSavedDelegate {
    
    func getInitialViewController() -> UIViewController
}


extension SceneDelegate: CheckIfTokenWasSavedDelegate {
    
    func getInitialViewController() -> UIViewController {
        
        var initialViewController: UIViewController
        
        let userManager = UserManager.shared
        
        let key = userManager.getKeyName()
        
        if userManager.containsThis(key: key) {

            let dropDownMenuRepository = DropDownMenuRepository()
            let dropDownMenuViewModel = DropDownMenuViewModel(repository: dropDownMenuRepository)
            let homeViewModel = HomeViewModel(dropDownMenuViewModel: dropDownMenuViewModel)
            
            initialViewController = HomeViewController(viewModel: homeViewModel)
        }
        else {
            
            let loginRepository = LoginRepository()
            let loginViewModel = LoginViewModel(loginRepository: loginRepository, userManager: userManager)
            
            initialViewController = LoginViewController(loginViewModel: loginViewModel)
        }
        
        return initialViewController
        
    }
    
    
}
