//
//  HomeViewModel.swift
//  SwiftTemplate
//
//  Created by David Duarte on 22/6/22.
//

import Foundation

protocol HomeViewModelInterface {
    func getDemoLabel() -> String
}

class HomeViewModel: HomeViewModelInterface {
    
    func getDemoLabel() -> String {
        return "Hola Alkymer! ;)"
    }
}
