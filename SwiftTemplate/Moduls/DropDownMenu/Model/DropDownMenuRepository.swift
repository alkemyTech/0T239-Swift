//
//  DropDownMenuRepository.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 11-07-22.
//

import Foundation
import UIKit

protocol DropDownMenuRepositoryProtocol: AnyObject {
    func getMenuItems() -> [MenuItem]
}

class DropDownMenuRepository: DropDownMenuRepositoryProtocol {
    
    func getMenuItems() -> [MenuItem] {
        let menuItems = [
            MenuItem(title: "Inicio", image: "house"),
            MenuItem(title: "Staff", image: "staff"),
            MenuItem(title: "Novedades", image: "novedades"),
            MenuItem(title: "Contribuir", image: "contribuir"),
            MenuItem(title: "Contacto", image: "contacto")
        ]
        return menuItems
    }
}
