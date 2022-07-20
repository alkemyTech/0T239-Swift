//
//  MembersRepository.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 18-07-22.
//

import Foundation

protocol MembersRepositoryProtocol {
    func getMembers() -> MembersModel
}

class MembersRepository: MembersRepositoryProtocol {
    
    func getMembers() -> MembersModel {
        let members = MembersModel(success: true, data: [
            Member(id: 589, name: "Maria Irola", image: "mariaIrola", description: "Presidenta", largeDescription: "Presidenta Maria Irola, Presidenta Maria Irola, Presidenta Maria Irola, Presidenta Maria Irola Presidenta Maria Irola, Presidenta Maria Irola, Presidenta Maria Irola, Presidenta Maria Irola, Presidenta Maria Irola Presidenta Maria Irola"),
            
            Member(id: 835, name: "Julian Fernandez", image: "memberImage", description: "Ceo/Cofunder", largeDescription: "Ceo Juan Fernandez, Ceo Juan Fernandez, Ceo Juan Fernandez, Ceo Juan Fernandez, Ceo Juan Fernandez, Ceo Juan Fernandez, Ceo Juan Fernandez, Ceo Juan Fernandez, Ceo Juan Fernandez, Ceo Juan Fernandez, Ceo Juan Fernandez, Ceo Juan Fernandez"),
            
            Member(id: 827, name: "Maria Garcia", image: "mariaGarcia", description: "Profesora de Artes Dramáticas", largeDescription: "Profesora de Artes Dramáticas Maria Garcia, Profesora de Artes Dramáticas, Profesora de Artes Dramáticas, Profesora de Artes Dramáticas, Profesora de Artes Dramáticas Maria Garcia, Profesora de Artes Dramáticas, Profesora de Artes Dramáticas, Profesora de Artes Dramáticas"),
            
            Member(id: 835, name: "Maria Irola", image: "mariaIrola", description: "Presidenta", largeDescription: "Presidenta Maria Irola, Presidenta Maria Irola, Presidenta Maria Irola, Presidenta Maria Irola Presidenta Maria Irola, Presidenta Maria Irola, Presidenta Maria Irola, Presidenta Maria Irola, Presidenta Maria Irola Presidenta Maria Irola"),
            
            Member(id: 827, name: "Julian Fernandez", image: "memberImage", description: "Ceo/Cofunder", largeDescription: "Ceo Juan Fernandez, Ceo Juan Fernandez, Ceo Juan Fernandez, Ceo Juan Fernandez, Ceo Juan Fernandez, Ceo Juan Fernandez, Ceo Juan Fernandez, Ceo Juan Fernandez, Ceo Juan Fernandez, Ceo Juan Fernandez, Ceo Juan Fernandez, Ceo Juan Fernandez"),
            
            Member(id: 589, name: "Maria Garcia", image: "mariaGarcia", description: "Profesora de Artes Dramáticas", largeDescription: "Profesora de Artes Dramáticas Maria Garcia, Profesora de Artes Dramáticas, Profesora de Artes Dramáticas, Profesora de Artes Dramáticas, Profesora de Artes Dramáticas Maria Garcia, Profesora de Artes Dramáticas, Profesora de Artes Dramáticas, Profesora de Artes Dramáticas"),
        ])
        return members
    }
}
