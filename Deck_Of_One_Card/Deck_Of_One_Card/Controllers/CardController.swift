//
//  CardController.swift
//  Deck_Of_One_Card
//
//  Created by Tim Green on 5/4/21.
//

import UIKit

class CardController {
    
    // MARK: - Functions
    static func fetchCard(completion: @escaping (Result <Card, CardError>) -> Void) {
        // https://deckofcardsapi.com/api/deck/new/draw/?count=1
        // STEP 1 - Prepare URL
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1") else { return completion(.failure(.invalidURL))}
        
        // STEP 2 - Contact Server
        URLSession.shared.dataTask(with: url) { data, _, error in
            // STEP 3 - Error Handling
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.thrownError(error)))
            }
            
            
            // STEP 4 - Check for JSON Data
            guard let data = data else { return completion(.failure(.noData))}
            //guard let data = data { return completion([]) }
            
            
            // STEP 5 - Decode JSON data into a Card
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                if let firstCard = topLevelObject.cards.first {
                    completion(.success(firstCard))
                } else {
                    completion(.failure(.noData))
                }
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
        
    } // End of fetchCard function
    
    static func fetchImage(for card: Card, completion: @escaping (Result<UIImage, CardError>) -> Void) {
        
        // STEP 1 - Create your URL
        guard let url = URL(string: card.image.description) else { return completion(.failure(.invalidURL)) }
        
        // STEP 2 - Data Task
        URLSession.shared.dataTask(with: url) { data, _, error in
            // STEP 3 - Error Handling
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.thrownError(error))) }
            // STEP 4 - Check for Data
            guard let data = data else { return completion(.failure(.noData)) }
            // STEP 5 - Decode Data
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            completion(.success(image))
            
        }.resume()
    } // End of fetchImage function
    
} // End of class
