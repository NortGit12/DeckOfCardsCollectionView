//
//  DeckController.swift
//  DeckOfCardsCollectionView
//
//  Created by Jeff Norton on 8/30/16.
//  Copyright © 2016 JCN. All rights reserved.
//

import Foundation

class DeckController {
    
    //==================================================
    // MARK: - Stored Properties
    //==================================================
    
    let newDeckURL = NSURL(string: "http://deckofcardsapi.com/api/deck/new/")
    let getCardsForDeckPrefixURL = NSURL(string: "http://deckofcardsapi.com/api/deck")
    let getCardsForDeckSuffixURLString = "draw/"
    static let deckIDKey = "deck_id"
    static let cardsKey = "cards"
    
    //==================================================
    // MARK: - Methods
    //==================================================
    
    func getNewDeck(completion: ((deckID: String?) -> Void)? = nil) {
        
        if let newDeckURL = newDeckURL {
            
            NetworkController.performRequestForURL(newDeckURL, httpMethod: .Get) { (data, error) in
                
                guard let data = data
                    , responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) as? String
                    , jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String : AnyObject]
                    , newDeckID = jsonDictionary[DeckController.deckIDKey] as? String
                    else {
                
                        if let completion = completion {
                            completion(deckID: nil)
                        }
                        
                        return
                    }
                
                if error != nil {
                    
                    NSLog("Error: There was an error getting a new deck: \(error)")
                    
                    if let completion = completion {
                        completion(deckID: nil)
                    }
                    
                    return
                }
                
                if responseDataString.containsString("error") {
                    
                    NSLog("Error: There was an error in the data: \(error)")
                    
                    if let completion = completion {
                        completion(deckID: nil)
                    }
                    
                    return
                }
                
                if let completion = completion {
                    
                    dispatch_async(dispatch_get_main_queue(), {
                    
                        completion(deckID: newDeckID)
                    })
                }
            }
        }
    }
    
    func fillDeckWithCards(deckID: String, completion: ((cards: [Card]?) -> Void)? = nil) {
        
        guard let fullURL = getCardsForDeckPrefixURL?.URLByAppendingPathComponent(deckID).URLByAppendingPathComponent(getCardsForDeckSuffixURLString) else { return }
        
        let urlParameters = ["count": "52"]
        
        NetworkController.performRequestForURL(fullURL, httpMethod: .Get, urlParameters: urlParameters, body: nil) { (data, error) in
            
            guard let data = data
                , responseDataString = NSString(data: data, encoding: NSUTF8StringEncoding) as? String
                , jsonDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String : AnyObject]
                , cardsDictionaryArray = jsonDictionary[DeckController.cardsKey] as?  [[String: AnyObject]]
                else {
                    
                    if let completion = completion {
                        completion(cards: nil)
                    }
                    
                    return
            }
            
            if error != nil {
                
                NSLog("Error: There was an error getting a new deck: \(error)")
                
                if let completion = completion {
                    completion(cards: nil)
                }
                
                return
            }
            
            if responseDataString.containsString("error") {
                
                NSLog("Error: There was an error in the data: \(error)")
                
                if let completion = completion {
                    completion(cards: nil)
                }
                
                return
            }
            
            let cardsArray = cardsDictionaryArray.flatMap({ Card(dictionary: $0) })
            
            if let completion = completion {
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    completion(cards: cardsArray)
                })
            }
        }
    }
}




















