//
//  ImageController.swift
//  DeckOfCardsCollectionView
//
//  Created by Jeff Norton on 8/30/16.
//  Copyright © 2016 JCN. All rights reserved.
//

import UIKit

class ImageController {
    
    //==================================================
    // MARK: - Methods
    //==================================================
    
    static func retrieveImageForURL(url: String, completion: ((image: UIImage?) -> Void)) {
        
        guard let url = NSURL(string: url) else {
            
            NSLog("Error: The image could not be located.")
            return
        }
        
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            
            guard let data = data else {
                
                completion(image: nil)
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                
                completion(image: UIImage(data: data))
            })
        }
    }
}