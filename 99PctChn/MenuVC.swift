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
    
    let context = delegate.persistentContainer.viewContext
    
    var allCards = [Card]()
    var zeroDeck = [Card]()
    var otherDecks = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForFirstLaunch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateView()
    }
    
    //---IBAction Functions---

    @IBAction func reviewNew(_ sender: AnyObject) {
        
    }
    
    @IBAction func reviewOld(_ sender: AnyObject) {
        
    }
    
    //---Custom Functions---
    
    func updateAllCards() {
        let request: NSFetchRequest<Card> = Card.fetchRequest()
        do {
            allCards = try context.fetch(request)
        } catch {
            fatalError("Failed to fetch Cards: \(error)")
        }
    }
    
    func updateView(){
        
        updateAllCards()
        var zero = 0, one = 0, two = 0, three = 0
        for card in allCards {
            switch(card.deck) {
            case 0:
                zero += 1
                zeroDeck.append(card)
            case 1:
                one += 1
                otherDecks.append(card)
            case 2:
                two += 1
                otherDecks.append(card)
            case 3:
                three += 1
                otherDecks.append(card)
            default:
                print("DEFAULT: \(card.deck)")
            }
        }
        
        self.zero.text = "\(zero)"
        self.one.text = "\(one)"
        self.two.text = "\(two)"
        self.three.text = "\(three)"
        
        if otherDecks.count == 0 {
            oldBtn.isEnabled = false
        }
        
    }
    
    func checkForFirstLaunch(){
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if !launchedBefore {
            setUpView()
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
    }
    
    func setUpView(){
        loadCardDataIntoDB(file: "1-100", rank: 0)
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

