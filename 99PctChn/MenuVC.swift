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
    
    var zeroDeck, otherDecks = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForFirstLaunch()
        updateView()
        
        if otherDecks.count == 0 {
            oldBtn.isEnabled = false
        }
    }
    
    //---IBAction Functions---

    @IBAction func reviewNew(_ sender: AnyObject) {
        
    }
    
    @IBAction func reviewOld(_ sender: AnyObject) {
        
    }
    
    //---Custom Functions---
    
    func checkForFirstLaunch(){
        
    }
    
    func updateView(){
        
    }
    
    func setUpView(){
        
    }
    
    func loadCardDataIntoDB(file: String) {
        
    }
}

