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
    func presentView(viewController: UIViewController, menuItem: Int)
}

class HomeViewModel: HomeViewModelInterface {
   
    private let dropDownMenuViewModel: DropDownMenuViewModelInterface
    private let newsViewModel: NewsViewModelInterface
   
    init(dropDownMenuViewModel: DropDownMenuViewModelInterface, newsViewModel: NewsViewModelInterface) {
        self.dropDownMenuViewModel = dropDownMenuViewModel
        self.newsViewModel = newsViewModel
    }
    
    func presentDropDownMenu(viewController: UIViewController) {
        let dropDownMenuViewController = DropDownMenuViewController(dropDownMenuViewModel: dropDownMenuViewModel)
        dropDownMenuViewController.delegate = viewController as? DropDownMenuViewControllerInterface
        dropDownMenuViewController.modalPresentationStyle = .overCurrentContext
        viewController.present(dropDownMenuViewController, animated: true)
    }
    
    func presentView(viewController: UIViewController, menuItem: Int) {
        switch menuItem {
        case 2:
            let newsViewController = NewsViewController(newsViewModel: newsViewModel)
            viewController.present(newsViewController, animated: true)
        default:
            print(menuItem)
        }
    }
}
