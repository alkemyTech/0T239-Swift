//
//  HomeViewModel.swift
//  SwiftTemplate
//
//  Created by David Duarte on 22/6/22.
//

import Foundation
import UIKit

protocol HomeViewModelInterface {
    func presentDropDownMenu(viewController: UIViewController)
}

class HomeViewModel: HomeViewModelInterface {
    
    func presentDropDownMenu(viewController: UIViewController) {
        let dropDownMenuRepository = DropDownMenuRepository()
        let dropDownMenuViewModel = DropDownMenuViewModel(repository: dropDownMenuRepository)
        let dropDownMenuViewController = DropDownMenuViewController(dropDownMenuViewModel: dropDownMenuViewModel)
        dropDownMenuViewController.modalPresentationStyle = .overCurrentContext
        viewController.present(dropDownMenuViewController, animated: true)
    }
}
