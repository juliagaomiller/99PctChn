//
//  StudyVC.swift
//  99PctChn
//
//  Created by Julia Miller on 11/15/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class StudyVC: UIViewController {
    
    @IBOutlet weak var main: UILabel!
    @IBOutlet weak var translation: UILabel!
    @IBOutlet weak var exChn: UILabel!
    @IBOutlet weak var exEng: UILabel!
    
    var deck: Deck!
    var currentCard: Card!
    
    var flippedBool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNextCard()
        for card in deck.cards {
            print("Rank: \(card.rank), Card: \(card.chinese)")
        }
    }
    
    //---IBAction Functions---
    
    @IBAction func flip(_ sender: AnyObject) {
        if flippedBool {
            flippedBool = false
        } else {
           flippedBool = true
        }
        showResults(flipped: flippedBool)
    }

    @IBAction func onePressed(_ sender: AnyObject) {
        currentCard.deck = 1
        delegate.saveContext()
        loadNextCard()
    }
    
    @IBAction func twoPressed(_ sender: AnyObject) {
        currentCard.deck = 2
        loadNextCard()
        delegate.saveContext()
    }
    
    @IBAction func threePressed(_ sender: AnyObject) {
        currentCard.deck = 3
        loadNextCard()
        delegate.saveContext()
    }
    
    //---Custom Functions---
    func loadNextCard(){
        
        var array = [Int]()
        for card in deck.cards {
            array.append(card.deck)
        }
        print("Decks: ", array)
        //EXPLANATION: The filter is to prevent next card from being the same as the current card
        let tempCards = deck.cards.filter({$0 != currentCard})
        let tempDeck = Deck(name: nil)
        tempDeck.cards = tempCards
        
        currentCard = tempDeck.pickCard()
        print("Current card is: \(currentCard.chinese) , rank: \(currentCard.rank)")
        flippedBool = false
        showResults(flipped: flippedBool)
    }
    
    func showResults(flipped: Bool) {
        main.textColor = currentCard.returnColor()
        if !flipped {
            main.text = currentCard.chinese
            translation.isHidden = true
            exChn.isHidden = true
            exEng.isHidden = true
        } else {
            main.text = currentCard.pinyin
            translation.text = currentCard.translation
            translation.isHidden = false
            if currentCard.example != "nil\r" {
                exChn.isHidden = false
                exChn.text = currentCard.example
            } else {
                exChn.isHidden = true
            }
            if currentCard.exampleTranslation != "nil\r" {
                exEng.isHidden = false
                exEng.text = currentCard.exampleTranslation
            } else {
                exEng.isHidden = true
            }
        }
    }
    
    
}


