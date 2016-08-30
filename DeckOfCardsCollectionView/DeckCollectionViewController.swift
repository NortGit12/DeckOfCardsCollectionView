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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
            
//            dispatch_async(dispatch_get_main_queue(), {
            
                guard let deckID = deckID else { return }
                
                self.deckController.fillDeckWithCards(deckID, completion: { (cards) in
                    
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    
                    if let cards = cards {
                        
                        self.deckOfCards = cards
                        self.collectionView?.reloadData()
                    }
                })
//            })
        }
    }

    //==================================================
    // MARK: - UICollectionViewDelegate
    //==================================================

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
