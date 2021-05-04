//
//  Card.swift
//  Deck_Of_One_Card
//
//  Created by Tim Green on 5/4/21.
//

import UIKit

struct TopLevelObject: Decodable {
    
    let cards: [Card]
    
}  // End of Struct

struct Card: Decodable {
    
    let value: String
    let suit: String
    let image: URL
    
    
    
}  // End of Struct

