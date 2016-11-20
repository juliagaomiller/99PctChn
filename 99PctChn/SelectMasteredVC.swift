//
//  SelectMasteredVC.swift
//  99PctChn
//
//  Created by Julia Miller on 11/19/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class SelectMasteredVC: UIViewController {
    
    @IBOutlet weak var leftTableView: UITableView!
    @IBOutlet weak var rightTableView: UITableView!
    
    var leftDeck = [Card]()
    var rightDeck = [Card]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftTableView.delegate = self
        leftTableView.dataSource = self
        
        rightTableView.delegate = self
        rightTableView.dataSource = self
    }

    
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
        return cell
    }
    
}
