//
//  Card.swift
//  DeckOfCardsCollectionView
//
//  Created by Jeff Norton on 8/30/16.
//  Copyright © 2016 JCN. All rights reserved.
//

import Foundation

class Card {
    
    //==================================================
    // MARK: - Stored Properties
    //==================================================
    
//    var cardValue: CardValue
//    var imageString: String
    
    let suit: String
    let value: String
    let imageURL: String
    
    private let suitKey = "suit"
    private let valueKey = "value"
    private let imageURLKey = "image"
    
    //==================================================
    // MARK: - Initializer
    //==================================================
    
//    init(cardValue: CardValue, imageString: String) {
//        
//        self.cardValue = cardValue
//        self.imageString = imageString
//    }
    
    init?(dictionary: [String: AnyObject]) {
        
        guard let suit = dictionary[suitKey] as? String
            , value = dictionary[valueKey] as? String
            , imageURL = dictionary[imageURLKey] as? String
            else { return nil }
        
        self.suit = suit
        self.value = value
        self.imageURL = imageURL
    }
}