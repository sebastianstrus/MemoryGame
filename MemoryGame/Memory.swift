//
//  Memory.swift
//  MemoryGame
//
//  Created by Sebastian Strus on 2018-02-04.
//  Copyright © 2018 Sebastian Strus. All rights reserved.
//

import Foundation
import UIKit


class Memory {
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index:Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if card match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                //either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
            
        }
        cards.shuffle(numberOfElements: numberOfPairsOfCards)
    }
    
    

    
    
}



extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle(numberOfElements: Int)
    {
        for _ in 1...numberOfElements
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}

