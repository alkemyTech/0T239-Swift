//
//  ExtensionSignUpViewController.swift
//  SwiftTemplate
//
//  Created by Pablo Manzur on 25/06/2022.
//

import Foundation
import UIKit


extension UIViewController {
    
    func showDialog(withTitle: String, saying: String, actionMessage: String, withAction: @escaping (UIAlertAction) -> Void) {
        
        let alert = UIAlertController(title: withTitle.uppercased(), message: saying, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: actionMessage, style: .default, handler: withAction ))
        
        self.present(alert, animated: true, completion: nil)
    }
}
