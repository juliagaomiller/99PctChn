//
//  StudyVC.swift
//  99PctChn
//
//  Created by Julia Miller on 11/15/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class StudyVC: UIViewController {
    
    @IBOutlet weak var flashcard: UILabel!
    
    var deck = [Card]()
    var currentCard: Card!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //---IBAction Functions---
    
    @IBAction func flip(_ sender: AnyObject) {
    }

    @IBAction func onePressed(_ sender: AnyObject) {
    }
    
    @IBAction func twoPressed(_ sender: AnyObject) {
    }
    
    @IBAction func threePressed(_ sender: AnyObject) {
    }
    
    //---Custom Functions---
    func loadNextCard(){
        
    }
    
    
}


