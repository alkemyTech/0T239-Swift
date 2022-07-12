//
//  DropDownMenuViewModel.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 11-07-22.
//

import Foundation
import UIKit


protocol DropDownMenuViewModelInterface {
   func getMenuItems() -> [MenuItem]
}

class DropDownMenuViewModel: DropDownMenuViewModelInterface {
 
    private let repository: DropDownMenuRepositoryProtocol
    
    init(repository: DropDownMenuRepositoryProtocol) {
        self.repository = repository
    }
    
    func getMenuItems() -> [MenuItem] {
        repository.getMenuItems()
    }
}
