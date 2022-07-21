//
//  Extension+SceneDelegate.swift
//  SwiftTemplate
//
//  Created by Pablo Manzur on 16/07/2022.
//

import Foundation
import UIKit

protocol CheckIfTokenWasSavedDelegate {
    
    func getInitialViewController(userManager: UserManager) -> UIViewController
}


extension SceneDelegate: CheckIfTokenWasSavedDelegate {
    
    func getInitialViewController(userManager: UserManager) -> UIViewController {
        
        var initialViewController: UIViewController
        
        let key = userManager.getKeyName()
        
        if userManager.containsThis(key: key) {

            let dropDownMenuRepository = DropDownMenuRepository()
            let dropDownMenuViewModel = DropDownMenuViewModel(repository: dropDownMenuRepository)
            let homeViewModel = HomeViewModel(dropDownMenuViewModel: dropDownMenuViewModel)
            
            let membersRepository = MembersRepository()
            let membersViewModel = MembersViewModel(repository: membersRepository)
            initialViewController = HomeViewController(viewModel: homeViewModel, membersViewModel: membersViewModel)
        }
        else {
            
            let loginRepository = LoginRepository()
            let loginViewModel = LoginViewModel(loginRepository: loginRepository, userManager: userManager)
            
            initialViewController = LoginViewController(loginViewModel: loginViewModel)
        }
        
        return initialViewController
        
    }
    
    
}
