//
//  NewsViewModel.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 20-07-22.
//

import Foundation

protocol NewsViewModelInterface {
    func getNews() -> [News]
}

class NewsViewModel: NewsViewModelInterface {
    
    let repository: NewsRepositoryProtocol
    
    init(repository: NewsRepositoryProtocol) {
        self.repository = repository
    }
    
    func getNews() -> [News] {
        return repository.getNews().data
    }
}
