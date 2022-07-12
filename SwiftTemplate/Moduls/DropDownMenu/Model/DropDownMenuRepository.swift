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
            MenuItem(name: "Inicio", image: "house"),
            MenuItem(name: "Staff", image: "staff"),
            MenuItem(name: "Novedades", image: "novedades"),
            MenuItem(name: "Contribuir", image: "contribuir"),
            MenuItem(name: "Contacto", image: "contacto")
        ]
        return menuItems
    }
}
