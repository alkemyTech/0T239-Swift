//
//  TestimonialsResponse.swift
//  SwiftTemplate
//
//  Created by Pablo Manzur on 21/07/2022.
//

import Foundation


struct TestimonialsResponse {
    let success: Bool
    let data: [Testimonial]
    let message: String
}


struct Testimonial {
    let id: Int
    let name: String
    let image: String
    let description: String
}
