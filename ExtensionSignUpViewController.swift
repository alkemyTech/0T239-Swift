//
//  ExtensionSignUpViewController.swift
//  SwiftTemplate
//
//  Created by Pablo Manzur on 25/06/2022.
//

import Foundation
import UIKit


extension UIViewController {
    
    func showDialog(withTitle: String, saying: String) {
        
        let alert = UIAlertController(title: withTitle.uppercased(), message: saying, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Back to Log in", style: .default, handler: { action in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
