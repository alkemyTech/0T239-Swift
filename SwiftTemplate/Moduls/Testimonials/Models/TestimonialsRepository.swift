//
//  TestimonialsRepository.swift
//  SwiftTemplate
//
//  Created by Pablo Manzur on 22/07/2022.
//

import Foundation

protocol TestimonialsRepositoryProtocol {
    func getTestimonials() -> TestimonialsResponse
}

class TestimonialsRepository: TestimonialsRepositoryProtocol {
    
    func getTestimonials() -> TestimonialsResponse {
        let testimonials = TestimonialsResponse(success: true, data: [
            Testimonial(id: 466, name: "Noelia Acevedo", image: "TestimonialImage", description: "Somos Más ayuda a incorporar en la vida de los niños y adolescentes hábitos sanos, mediante actividades que les brinda contención emocional y afectiva."),
            
            Testimonial(id: 479, name: "Barack Obama", image: "TestimonialImage", description: "Somos Más es una organizacion benéfica que aporta mucho a la sociedad."),
            
            Testimonial(id: 484, name: "Javier Figuera", image: "TestimonialImage", description: "La sonrisa de los niños y los abrazos se convirtieron en la recompensa mas valiosa de mis días. Gracias Somos Más por permitirme formar parte de su ONG.")],
                                                
                                                message: "Testimonials retrieved successfully")
        
        return testimonials
    }
    
    
}
