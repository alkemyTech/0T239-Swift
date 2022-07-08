//
//  ApiError.swift
//  SwiftTemplate
//
//  Created by Pablo Manzur on 03/07/2022.
//

import Foundation


enum ApiError: String {
    
    case ConnectionError = "The server responded with a non 200 status code"
    case NoDataError = "We got no data (0 bytes) back from the server"
    
}
