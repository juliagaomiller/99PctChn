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
    
    init(name: Int?){
        self.name = name
    }
    
    func sortByRank(){
        cards = cards.sorted(by: { $1.rank > $0.rank })
    }
    
    func sortByDeck(){
        cards = cards.sorted(by: { $1.deck > $0.deck })
    }
    
    func removeCard(card:Card){
        cards = cards.filter({$0 != card})
    }
    
    func returnDeckWithout(card: Card) -> [Card]{
        let deck = cards.filter({$0 != card})
        return deck
    }
    
    func pickCard() -> Card? {
        let num = returnNumberOfDecks()
        if num == 0 {
            return cards.chooseRandom()
        } else {
            var i = 1
            self.sortByDeck()
            var decks = [[Card]]()
            var deck = [Card]()
            deck.append(cards[0])
            while i < cards.count {
                if cards[i].deck == cards[i-1].deck {
                    deck.append(cards[i])
                } else {
                    decks.append(deck)
                    deck.removeAll()
                    deck.append(cards[i])
                    if i == cards.count - 1 {
                        decks.append(deck)
                    }
                }
                i += 1
            }
            print("Cards were compiled into \(decks.count) decks")
            let deckNum = pickDeck()
            print("The number of cards in this deck is: ", decks[deckNum].count)
            if decks[deckNum].count == 1 {
                return decks[deckNum][0]
            } else {
              return decks[deckNum].chooseRandom()
            }
        }
    }
    
    func pickDeck() -> Int {
        let num = returnNumberOfDecks()
        if num == 0 {
            return 0
        } else {
            var array = [Int]()
            var x = 0
            var i = num + 1
            while x <= num {
                while i >= 0 {
                    array.append(x)
                    i -= 1
                }
                x += 1
                i = num - x
            }
            array.removeFirst()
            print("Choices: ", array)
            let choice = array.chooseRandom()
            print("Chose: ", choice)
            return choice
        }
    }
    
    func returnNumberOfDecks() -> Int {
        if cards.count == 1 {
            return 0
        } else {
            var array = [Int]()
            for c in cards {
               array.append(c.deck)
            }
            array = array.removeDuplicates()
            print("Decks present: ", array)
            if array.count == 1 {
                return 0
            } else {
               return array.count-1
            }
            
        }
    }
}
