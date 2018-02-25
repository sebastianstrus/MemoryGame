//
//  Card.swift
//  MemoryGame
//
//  Created by Sebastian Strus on 2018-02-04.
//  Copyright © 2018 Sebastian Strus. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
