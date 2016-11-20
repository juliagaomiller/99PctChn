//
//  AllCardsVC.swift
//  99PctChn
//
//  Created by Julia Miller on 11/18/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class AllCardsVC: UIViewController {
    
    @IBOutlet weak var greyBtn: UIButton!
    @IBOutlet weak var redBtn: UIButton!
    @IBOutlet weak var yellowBtn: UIButton!
    @IBOutlet weak var greenBtn: UIButton!
    @IBOutlet weak var blueBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    var allCards = [Card]()
    var displayDeck = Deck()
    var allDecks = [Deck(), Deck(), Deck(), Deck(), Deck()]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        print(displayDeck.cards.count)
        populateDecks()

    }

    @IBAction func greyPressed(_ sender: AnyObject) {
        updateDisplayDeck(i: 0)
    }
    @IBAction func redPressed(_ sender: AnyObject) {
        updateDisplayDeck(i: 1)
    }
    @IBAction func yellowPressed(_ sender: AnyObject) {
        updateDisplayDeck(i: 2)
    }
    @IBAction func greenPressed(_ sender: AnyObject) {
        updateDisplayDeck(i: 3)
    }
    @IBAction func bluePressed(_ sender: AnyObject) {
        updateDisplayDeck(i: 4)
    }
    
    func updateDisplayDeck(i: Int){
        if allDecks[i].isEmpty() {
            return
        }
        if displayDeck.containsDeck(deck: i) {
            if displayDeck.returnNumberOfDecks() != 0 {
                displayDeck.removeDeck(deck: i)
            } else {
                return
            }
        } else {
            displayDeck.cards.append(contentsOf: allDecks[i].cards)
        }
        displayDeck.sortByRank()
        tableView.reloadData()
    }
    
    func populateDecks(){
        for c in allCards {
            switch(c.deck) {
            case 0:
                allDecks[0].cards.append(c)
            case 1:
                allDecks[1].cards.append(c)
            case 2:
                allDecks[2].cards.append(c)
            case 3:
                allDecks[3].cards.append(c)
            case 4:
                allDecks[4].cards.append(c)
            default:
                fatalError("Error. Deck out of range: \(c.deck)")
            }
        }
        
    }
    

}

extension AllCardsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayDeck.cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let card = displayDeck.cards[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlainCardCell") as! PlainCardCell
        cell.configureCell(card: card)
        return cell
    }
    
}
