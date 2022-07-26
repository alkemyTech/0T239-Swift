//
//  TestimonialsViewModel.swift
//  SwiftTemplate
//
//  Created by Pablo Manzur on 21/07/2022.
//

import Foundation

protocol TestimonialsViewModelInterface {
    func getTestimonials() -> [Testimonial]
}

class TestimonialsViewModel: TestimonialsViewModelInterface {
    
    private let testimonialRepository = TestimonialsRepository()
    
    
    func getTestimonials() -> [Testimonial] {
        self.testimonialRepository.getTestimonials().data
    }
    
}
