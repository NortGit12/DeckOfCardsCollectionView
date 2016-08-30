//
//  DeckCollectionViewCell.swift
//  DeckOfCardsCollectionView
//
//  Created by Jeff Norton on 8/30/16.
//  Copyright © 2016 JCN. All rights reserved.
//

import UIKit

class DeckCollectionViewCell: UICollectionViewCell {
    
    //==================================================
    // MARK: - Stored Properties
    //==================================================
    
    @IBOutlet weak var cardImageView: UIImageView!
    
    //==================================================
    // MARK: - Methods
    //==================================================
    
    func updateWithCard(card: Card) {
        
        ImageController.retrieveImageForURL(card.imageURL) { (image) in
            
            if let image = image {
                self.cardImageView.image = image
            }
        }
    }
    
}
