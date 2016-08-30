//
//  Deck.swift
//  DeckOfCardsCollectionView
//
//  Created by Jeff Norton on 8/30/16.
//  Copyright © 2016 JCN. All rights reserved.
//

import Foundation

class Deck {
    
    //==================================================
    // MARK: - Stored Properties
    //==================================================
    
    var cards = [Card]()
    
    //==================================================
    // MARK: - Methods
    //==================================================
    
    func addCard(card: Card) {
        cards.append(card)
    }
}