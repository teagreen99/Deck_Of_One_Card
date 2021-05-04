//
//  CardError.swift
//  Deck_Of_One_Card
//
//  Created by Tim Green on 5/4/21.
//

import Foundation

enum CardError: LocalizedError {
    
    case invalidURL 
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Internal error. Please update Deck of One Card or contact support."
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "The server responded with no data."
        case .unableToDecode:
            return "The data responded with bad data."
        }
    }
}
