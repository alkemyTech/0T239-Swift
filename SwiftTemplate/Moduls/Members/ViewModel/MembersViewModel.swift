//
//  MembersViewModel.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 18-07-22.
//

import Foundation

protocol MembersViewModelInterface {
    func getMembers() -> [Member]
}

class MembersViewModel: MembersViewModelInterface {
    
    private let repository: MembersRepositoryProtocol
    
    init(repository: MembersRepositoryProtocol) {
        self.repository = repository
    }

    func getMembers() -> [Member] {
      return repository.getMembers().data
    }
}
