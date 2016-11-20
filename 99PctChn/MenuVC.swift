//
//  MenuVC.swift
//  99PctChn
//
//  Created by Julia Miller on 11/15/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit
import CoreData

class MenuVC: UIViewController {
    
    @IBOutlet weak var one: UILabel!
    @IBOutlet weak var two: UILabel!
    @IBOutlet weak var three: UILabel!
    @IBOutlet weak var oldBtn: UIButton!
    @IBOutlet weak var masteredBtn: UIButton!
    @IBOutlet weak var allCardsBtn: UIButton!
    
    
    let context = delegate.persistentContainer.viewContext
    
    var completeDeck = Deck()
    var backgroundDeck = Deck()
    var zeroDeck = Deck()
    var masteredDeck = Deck()
    var otherDecks = Deck()
    
    //---Override Functions---
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        checkForFirstLaunch()
        updateView()
        
        //DELETE BELOW
        zeroDeck.sortByRank()
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectMasteredVC") as! SelectMasteredVC
        let split = zeroDeck.cards.split()
        newVC.leftDeck.append(contentsOf: split[0])
        newVC.rightDeck.append(contentsOf: split[1])
        self.show(newVC, sender: nil)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        switch (identifier) {
        case "NewSegue":
            var i = 0
            let deck = Deck()
            while i < 10 {
                deck.cards.append(zeroDeck.cards[i])
                i += 1
            }
            let vc = segue.destination as! StudyVC
            vc.deck = deck
        case "OldSegue":
            let vc = segue.destination as! StudyVC
            vc.deck = otherDecks
        case "SettingsSegue":
            let vc = segue.destination as! SettingsVC
            vc.allCards = completeDeck.cards
        case "GreySegue":
            let vc = segue.destination as! AllCardsVC
            vc.allCards = completeDeck.cards
            vc.displayDeck = zeroDeck
        default:
            break
        }
    }
    
    //---Custom Functions---
    
    func setUpView(){
        loadCardDataIntoDB(file: "1-500")
        updateAllCards()
        appendHundredNewCardsToZeroDeck(deck: completeDeck)

    }
    
    func updateAllCards() {
        let request: NSFetchRequest<Card> = Card.fetchRequest()
        do {
            let cards = try context.fetch(request)
            completeDeck.cards = cards
            completeDeck.sortByRank()
        } catch {
            fatalError("Failed to fetch Cards: \(error)")
        }
    }
    
    func checkForFirstLaunch(){
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if !launchedBefore {
            setUpView()
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
    }
    
    func appendHundredNewCardsToZeroDeck(deck: Deck){
        let cards = deck.cards
        var i = 0
        while i < 100 {
            cards[i].deck = 0
            zeroDeck.cards.append(cards[i])
            i += 1
        }
        
//        zeroDeck.sortByRank()
//        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectMasteredVC") as! SelectMasteredVC
//        let split = zeroDeck.cards.split()
//        newVC.leftDeck.append(contentsOf: split[0])
//        newVC.rightDeck.append(contentsOf: split[1])
//        self.show(newVC, sender: nil)
    }
    
    func updateView(){
        
        updateAllCards()
        var zero = 0, one = 0, two = 0, three = 0, four = 0
        for card in completeDeck.cards {
            switch(card.deck) {
            case -1:
                backgroundDeck.cards.append(card)
            case 0:
                zero += 1
                zeroDeck.cards.append(card)
                zeroDeck.cards = zeroDeck.cards.removeDuplicates()
            case 1:
                one += 1
                otherDecks.cards.append(card)
            case 2:
                two += 1
                otherDecks.cards.append(card)
            case 3:
                three += 1
                otherDecks.cards.append(card)
            case 4:
                four += 1
                masteredDeck.cards.append(card)
            default:
                fatalError("Card deck is out of range: \(card.deck)")
            }
        }
        
        if zeroDeck.cards.count == 0 {
            appendHundredNewCardsToZeroDeck(deck: backgroundDeck)
        }
        
        zeroDeck.sortByRank()
        self.allCardsBtn.setTitle("\(zero)/\(completeDeck.cards.count)", for: .normal)
        self.one.text = "\(one)"
        self.two.text = "\(two)"
        self.three.text = "\(three)"
        masteredBtn.setTitle("\(four)", for: .normal)
        
        if otherDecks.cards.count == 0 {
            oldBtn.isEnabled = false
        }
        
    }
    
    func loadCardDataIntoDB(file: String) {
        if let path = Bundle.main.path(forResource: file, ofType: "txt") {
            do {
                var newString = try String(contentsOfFile: path, encoding: .utf8)
                newString = newString.replacingOccurrences(of: "\n\n", with: "")
                newString = newString.replacingOccurrences(of: "\r", with: "")
                var flashcard = newString.components(separatedBy: "++")
                flashcard.removeLast()
                var card: [(rank: Int, chinese: String, pinyin: String, translation: String, chn: String, eng: String)] = []
                for c in flashcard {
                    var array = c.components(separatedBy: "||")
                    array.removeLast()
                    array.removeFirst()
                    card.append((rank: Int(array[0])!, chinese: array[1],
                                 pinyin: array[2], translation: array[3],
                                 chn: array[4], eng: array[5]))
                }
                for c in card {
                    let _ = Card(rank: c.rank, chinese: c.chinese, pinyin: c.pinyin, translation: c.translation, example: c.chn, exampleTranslation: c.eng, context: context)
                }
                delegate.saveContext()
            } catch {
                print(error)
            }

        }
    }
}

