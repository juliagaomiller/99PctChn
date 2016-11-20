//
//  MasteredCell.swift
//  99PctChn
//
//  Created by Julia Miller on 11/19/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class MasteredCell: UITableViewCell {
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var chnLabel: UILabel!
    
    weak var delegate: CheckForDoubleTap?
    
    let h = Helper()
    var card: Card?
    var double = false, single = false

    override func awakeFromNib() {
        super.awakeFromNib()
//        addGesturesRecognizers()
    }
    
//    func addGesturesRecognizers(){
//        let doubletap = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
//        doubletap.numberOfTapsRequired = 2
//        
//        self.addGestureRecognizer(doubletap)
//        let singletap = UITapGestureRecognizer(target: self, action: #selector(singleTap))
//        singletap.numberOfTapsRequired = 1
//        self.addGestureRecognizer(singletap)
//    }

    
//    func singleTap(){
//        print(rankLabel.text!, chnLabel.text!)
//        if single {
//            chnLabel.backgroundColor = UIColor.clear
//            delegate?.removeFromMasteredCards(card: self.card!)
//        } else {
//            chnLabel.backgroundColor = h.lightBlue
//            single = true
//            delegate?.addToMasteredCards(card: self.card!)
//        }
//    }
//    
//    func doubleTap(){
//        if double {
//            chnLabel.backgroundColor = UIColor.clear
//            delegate?.removeFromMasteredCards(card: self.card!)
//            double = false
//        } else {
//            chnLabel.backgroundColor = UIColor.blue
//            delegate?.addToMasteredCards(card: self.card!)
//            double = true
//            single = false
//            delegate?.checkForDoubleTap(cell: self)
//        }
//        print(rankLabel.text!, chnLabel.text!)
//    }
    
    
    func configureCell(card: Card){
        self.card = card
        rankLabel.text = String(card.rank)
        chnLabel.text = card.chinese
    }

}
