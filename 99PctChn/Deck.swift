//
//  Deck.swift
//  99PctChn
//
//  Created by Julia Miller on 11/15/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation

class Deck {
    
    var name: Int?
    var cards = [Card]()
    
    init(name: Int?, cards: [Card]){
        self.name = name
        self.cards = cards
    }
    
    func sort(){
        
    }
    
    func pickCard() -> Card? {
        let card = cards[0]
        return card
    }
    
    func pickDeck() -> Int {
        return 0
        
    }
    
    func returnNumberOfDecks() -> Int {
        return 0
    }
}
