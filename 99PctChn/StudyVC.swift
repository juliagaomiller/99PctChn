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
    @IBOutlet weak var cardView: UIView!
    
    var deck = Deck()
    var currentCard: Card!
    
    var flippedBool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.layer.cornerRadius = 8.0
        loadNextCard(firstLaunch: true)
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
        loadNextCard(firstLaunch: false)
    }
    
    @IBAction func twoPressed(_ sender: AnyObject) {
        print("Deck countC: ", deck.cards.count)
        currentCard.deck = 2
        loadNextCard(firstLaunch: false)
        delegate.saveContext()
    }
    
    @IBAction func threePressed(_ sender: AnyObject) {
        currentCard.deck = 3
        loadNextCard(firstLaunch: false)
        delegate.saveContext()
    }
    
    @IBAction func masteredPressed(_ sender: AnyObject){
        deck.removeCard(card: currentCard)
        currentCard.deck = 4
        loadNextCard(firstLaunch: true)
        delegate.saveContext()
        
    }
    
    
    //---Custom Functions---
    func loadNextCard(firstLaunch: Bool){
        
        var array = [Int]()
        for card in deck.cards {
            array.append(card.deck)
        }
        print("Decks: ", array)
        
        print("Deck countA: \(deck.cards.count)")
        if deck.cards.count <= 1 {
            self.performSegue(withIdentifier: "StudyMenuSegue", sender: self)
        } else if deck.cards.count <= 3 {
            print("Deck countA.a: \(deck.cards.count)")
            if firstLaunch {
                currentCard = deck.cards.chooseRandom()
                print("Deck countA.b: \(deck.cards.count)")
            } else {
                let tempCards = deck.returnDeckWithout(card: currentCard)
                if deck.cards.count == 2 {
                    currentCard = tempCards[0]
                    print("Deck countA.c: \(deck.cards.count)")
                } else {
                    currentCard = tempCards.chooseRandom()
                    print("Deck countA.d: \(deck.cards.count)")
                }
            }
        } else {
            if firstLaunch {
                currentCard = deck.pickCard()
            } else {
                //EXPLANATION: Prevents from accidentally picking the same card.
                let tempCards = deck.returnDeckWithout(card: currentCard)
                let tempDeck = Deck()
                tempDeck.cards = tempCards
                currentCard = tempDeck.pickCard()
            }
        }
        print("Deck countB: \(deck.cards.count)")
        
        print("Current card is: \(currentCard.chinese) , rank: \(currentCard.rank)")
        flippedBool = false
        showResults(flipped: flippedBool)
    }
    
    func showResults(flipped: Bool) {
        let color = currentCard.returnColor()
        cardView.layer.backgroundColor = color.light.cgColor
        main.textColor = color.dark
        if !flipped {
            main.text = currentCard.chinese
            translation.isHidden = true
            exChn.isHidden = true
            exEng.isHidden = true
        } else {
            main.text = currentCard.pinyin
            translation.textColor = color.dark
            translation.text = currentCard.translation
            translation.isHidden = false
            if currentCard.example != "nil\r" {
                exChn.isHidden = false
                exChn.textColor = color.dark
                exChn.text = currentCard.example
            } else {
                exChn.isHidden = true
            }
            if currentCard.exampleTranslation != "nil\r" {
                exEng.isHidden = false
                exEng.textColor = color.dark
                exEng.text = currentCard.exampleTranslation
            } else {
                exEng.isHidden = true
            }
        }
    }
}


