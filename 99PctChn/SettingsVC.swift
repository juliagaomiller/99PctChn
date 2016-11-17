//
//  SettingsVC.swift
//  99PctChn
//
//  Created by Julia Miller on 11/16/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit
import CoreData

class SettingsVC: UIViewController {
    
    var allCards = [Card]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func resetCards(_ sender: AnyObject) {
        for card in allCards {
            card.deck = 0
        }
        delegate.saveContext()
        self.performSegue(withIdentifier: "SettingsMenuSegue", sender: self)
    }

}
