//
//  Errors.swift
//  TestDeliveryApp
//
//  Created by Lena Vorontsova on 04.04.2023.
//

import UIKit

enum Errors: Error {
    case invalidData
    case invalidURL
    case cannotComplete
    case invalidResponse
    case errorParsingJSON
}

extension Errors: LocalizedError {
    var errorDetails: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .cannotComplete:
            return "Please check your connection"
        case .invalidResponse:
            return "Invalid response received"
        case .invalidData:
            return "Data received is invalid"
        case .errorParsingJSON:
            return "Error Parsing JSON"
        }
    }
}
