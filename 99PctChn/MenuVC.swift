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
    
    @IBOutlet weak var zero: UILabel!
    @IBOutlet weak var one: UILabel!
    @IBOutlet weak var two: UILabel!
    @IBOutlet weak var three: UILabel!
    @IBOutlet weak var oldBtn: UIButton!
    @IBOutlet weak var masteredBtn: UIButton!
    
    let context = delegate.persistentContainer.viewContext
    
    var allCards = [Card]()
    var zeroDeck = Deck(name: 0)
    var masteredDeck = Deck(name: 4)
    var otherDecks = Deck(name: nil)
    
    //---Override Functions---
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForFirstLaunch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewSegue" {
            var i = 0
            let deck = Deck(name: 0)
            while i < 10 {
                deck.cards.append(zeroDeck.cards[i])
                i += 1
            }
            let vc = segue.destination as! StudyVC
            vc.deck = deck
        } else if segue.identifier == "OldSegue" {
            let vc = segue.destination as! StudyVC
            vc.deck = otherDecks
        } else if segue.identifier == "SettingsSegue" {
            let vc = segue.destination as! SettingsVC
            vc.allCards = allCards
        }
    }
    
    //---Custom Functions---
    
    func setUpView(){
        loadCardDataIntoDB(file: "1-100", rank: 0)
    }
    
    func updateAllCards() {
        let request: NSFetchRequest<Card> = Card.fetchRequest()
        do {
            allCards = try context.fetch(request)
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
    
    func updateView(){
        
        updateAllCards()
        var zero = 0, one = 0, two = 0, three = 0, four = 0
        for card in allCards {
            switch(card.deck) {
            case 0:
                zero += 1
                zeroDeck.cards.append(card)
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
        
        zeroDeck.sortByRank()
        
        self.zero.text = "\(zero)/\(allCards.count)"
        self.one.text = "\(one)"
        self.two.text = "\(two)"
        self.three.text = "\(three)"
        masteredBtn.setTitle("\(four)", for: .normal)
        
        if otherDecks.cards.count == 0 {
            oldBtn.isEnabled = false
        }
        
    }
    
    func loadCardDataIntoDB(file: String, rank: Int) {
        if let path = Bundle.main.path(forResource: file, ofType: "txt") {
            let data: String!
            do {
                data = try String(contentsOfFile: path, encoding: .utf8)
                //EXPLANATION: Turn txt text into chinese, translation, pinyin, example, exampleTranslation arrays.
                var parts = data.components(separatedBy: "\"")
                //EXPLANATION: What this starts out looking like.
//                for p in parts {
//                 print("|| ", p, "||")
//                 }
                let max = (parts.count-1)
                var translationArray = [String]()
                var other = ""
                var i = 0
                while i <= max {
                    other = other + parts[i]
                    if i+1 >= max {
                        break
                    }
                    translationArray.append(parts[i+1])
                    i += 2
                }
                parts = other.components(separatedBy: "\n,")
                other = ""
                for p in parts {
                    other = other + p
                }
                parts = other.components(separatedBy: "\n")
                var chineseArray = [String]()
                var pinyinArray = [String]()
                var exampleArray = [String]()
                var exampleTranslationArray = [String]()
                for p in parts {
                    var unit = p.components(separatedBy: ",")
                    chineseArray.append(unit[0])
                    pinyinArray.append(unit[1])
                    exampleArray.append(unit[2])
                    exampleTranslationArray.append(unit[3])
                }
                i = rank
                if translationArray.count != chineseArray.count {
                    fatalError("translation count = \(translationArray.count); chinese count = \(chineseArray.count)")
                }
                for _ in chineseArray {
                    let _ = Card(rank: i, chinese: chineseArray[i], pinyin: pinyinArray[i], translation: translationArray[i], example: exampleArray[i], exampleTranslation: exampleTranslationArray[i], context: context)
                    i += 1
                }
                delegate.saveContext()
            } catch {
                print(error)
            }

        }
    }
}

