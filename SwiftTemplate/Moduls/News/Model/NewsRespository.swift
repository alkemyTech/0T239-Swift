//
//  NewsRespository.swift
//  SwiftTemplate
//
//  Created by Cesar Castillo on 20-07-22.
//

import Foundation

protocol NewsRespositoryProtocol {
    func getNews() -> NewsModel
}

class NewsRespository: NewsRespositoryProtocol {
    
    func getNews() -> NewsModel {
        let news = NewsModel(succes: true, data: [
            News(name: "Más de 5.000 juguetes donados!", content: "Somos Más ha logrado conseguir más de 5.000 SONRISAS con los juguetes que se donaron a los niños, Somos Más ha logrado conseguir más de 5.000 SONRISAS con los juguetes que se donaron a los niños, Somos Más ha logrado conseguir más de 5.000 SONRISAS con los juguetes que se donaron a los niños", image: "juguetesDonados"),
            
            News(name: "Comenzaron nuestras campañas!", content: "Hay dos campañas activas, escolar y de juguetes. Para saber como colaborar y hasta cuando hay tiempo, visitá nuestra sección de campañas, Hay dos campañas activas, escolar y de juguetes. Para saber como colaborar y hasta cuando hay tiempo, visitá nuestra sección de campañas, Hay dos campañas activas, escolar y de juguetes. Para saber como colaborar y hasta cuando hay tiempo, visitá nuestra sección de campañas, Hay dos campañas activas, escolar y de juguetes. Para saber como colaborar y hasta cuando hay tiempo, visitá nuestra sección de campañas, Hay dos campañas activas, escolar y de juguetes. Para saber como colaborar y hasta cuando hay tiempo, visitá nuestra sección de campañas", image: "campañas"),
            
            News(name: "Tercer encuentro futbolero ⚽", content: "La próxima semana se dará el tercer encuentro de partidos de futbol entre las escuelas secundarias, La próxima semana se dará el tercer encuentro de partidos de futbol entre las escuelas secundarias, La próxima semana se dará el tercer encuentro de partidos de futbol entre las escuelas secundarias, La próxima semana se dará el tercer encuentro de partidos de futbol entre las escuelas secundarias", image: "encuentroFutbolero")
        ])
        return news
    }
}

