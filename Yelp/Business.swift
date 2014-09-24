//
//  Business.swift
//  Yelp
//
//  Created by Kumar, Chandaraprakash on 9/21/14.
//  Copyright (c) 2014 chantech. All rights reserved.
//

import Foundation

class Business {
    
    init() {
        
    }
    
    var id: String!
    var categories = [[String]]()
    var businessName: String!
    var thumbImageURL: String!
    var ratingsImageURL: String!
    var reviewCount: Int = 0
    var address: String!
    
}