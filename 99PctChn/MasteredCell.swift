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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        //Google "double tap on uitableviewcell
    }
    
    func configureCell(card: Card){
        rankLabel.text = String(card.rank)
        chnLabel.text = card.chinese
    }

}
