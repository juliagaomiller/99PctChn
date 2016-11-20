//
//  SelectMasteredVC.swift
//  99PctChn
//
//  Created by Julia Miller on 11/19/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

protocol CheckForDoubleTap: class {
    func addToMasteredCards(card: Card)
    func removeFromMasteredCards(card: Card)
    func checkForDoubleTap(cell: MasteredCell)
    func addMultipleToMasteredCards(beginIndex: Int, endIndex: Int)
}

class SelectMasteredVC: UIViewController {
    
    @IBOutlet weak var leftTableView: UITableView!
    @IBOutlet weak var rightTableView: UITableView!
    
    var leftDeck = [Card]()
    var rightDeck = [Card]()
    
//    let h = Helper()
    
    static var allCells = [MasteredCell]()
    
//    var masteredDeck = Deck()
//    var masteredCards = [Card]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftTableView.delegate = self
        leftTableView.dataSource = self
        
        rightTableView.delegate = self
        rightTableView.dataSource = self
        
//        addGesturesRecognizers()
    }
    
    @IBAction func donePressed(){
        //masteredcards.deck = 4
        //delegate.savecontext
    }
    
//    func addGesturesRecognizers(){
//        let double = UITapGestureRecognizer(target: self, action: #selector(doubleTap(gestureRecognizer:)))
//        double.numberOfTapsRequired = 2
//        self.rightTableView.addGestureRecognizer(double)
//        self.leftTableView.addGestureRecognizer(double)
//        let single = UITapGestureRecognizer(target: self, action: #selector(singleTap))
//        single.numberOfTapsRequired = 1
//        self.rightTableView.addGestureRecognizer(single)
//        self.leftTableView.addGestureRecognizer(single)
//    }
    
//    func doubleTap(gestureRecognizer: UITapGestureRecognizer){
//        var cell = MasteredCell()
//        let location: CGPoint = gestureRecognizer.location(in: self.customView)
//        if let indexPath = self.leftTableView.indexPathForRow(at: location){
//            cell = self.leftTalbleView.cellForRow(at: indexPath) as! MasteredCell!
//        } else if let indexPath = self.rightTableView.indexPathForRow(at: location){
//            cell = self.rightTableView.cellForRow(at: indexPath) as! MasteredCell!
//        } else { print("Did not tap on table") }
//        guard let _ = cell.card else { fatalError() }
//        if cell.double {
//            cell.chnLabel.backgroundColor = UIColor.clear
//            removeFromMasteredCards(card: cell.card!)
//            cell.double = false
//        } else {
//            cell.chnLabel.backgroundColor = UIColor.blue
//            addToMasteredCards(card: cell.card!)
//            cell.double = true
//            cell.single = false
//            checkForDoubleTap(cell: cell)
//        }
//    }
    
//    func singleTap(){
//        print("singleTapped")
//    }

    
}

extension SelectMasteredVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier: String!
        let deck: [Card]
        
        if tableView == leftTableView {
            identifier = "LeftCell"
            deck = leftDeck
        } else {
            identifier = "RightCell"
            deck = rightDeck
        }
        let card = deck[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! MasteredCell
        cell.configureCell(card: card)
        cell.delegate = self
        SelectMasteredVC.allCells.append(cell)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! MasteredCell
//        cell.updateClicks()
//        switch(cell.click){
//        case 0:
//            cell.backgroundColor = UIColor.clear
//        case 1:
//            cell.backgroundColor = h.lightBlue
//        case 2:
//            cell.backgroundColor = UIColor.blue
//        default:
//            fatalError()
//        }
//    }
}

extension SelectMasteredVC: CheckForDoubleTap {
    
    func addToMasteredCards(card: Card) {
        print("Added")
    }
    
    func removeFromMasteredCards(card: Card) {
        print("Removed")
    }
    
    func checkForDoubleTap(cell: MasteredCell) {
        print("CheckForDoubleTap")
    }
    
    func addMultipleToMasteredCards(beginIndex: Int, endIndex: Int) {
        //
    }
}
