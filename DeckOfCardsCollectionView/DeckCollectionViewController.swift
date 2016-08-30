//
//  DeckCollectionViewController.swift
//  DeckOfCardsCollectionView
//
//  Created by Jeff Norton on 8/30/16.
//  Copyright © 2016 JCN. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cardCell"

class DeckCollectionViewController: UICollectionViewController {
    
    //==================================================
    // MARK: - Stored Properties
    //==================================================
    
    let deckController = DeckController()
    var deckOfCards = [Card]()
    
    //==================================================
    // MARK: - General
    //==================================================

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //==================================================
    // MARK: - UICollectionViewDataSource
    //==================================================

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return deckOfCards.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? DeckCollectionViewCell else { return UICollectionViewCell() }
        
        let card = deckOfCards[indexPath.row]
    
        cell.updateWithCard(card)
    
        return cell
    }
    
    //==================================================
    // MARK: - Action(s)
    //==================================================
    
    @IBAction func newDeckButtonTapped(sender: UIBarButtonItem) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        deckController.getNewDeck { (deckID) in
            
            guard let deckID = deckID else { return }
            
            self.deckController.fillDeckWithCards(deckID, completion: { (cards) in
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
                if let cards = cards {
                    
                    self.deckOfCards = cards
                    self.collectionView?.reloadData()
                }
            })
        }
    }

}
