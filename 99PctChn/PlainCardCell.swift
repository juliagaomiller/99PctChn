//
//  PlainCardCell.swift
//  99PctChn
//
//  Created by Julia Miller on 11/18/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class PlainCardCell: UITableViewCell {
    
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var chinese: UILabel!
    @IBOutlet weak var pinyin: UILabel!
    @IBOutlet weak var translation: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(card: Card){
        let color = card.returnColor()
        self.backgroundColor = color.light
        self.rank.text = "\(card.rank)."
        self.chinese.text = card.chinese!
        self.pinyin.text = card.pinyin!
        self.translation.text = card.translation!
        self.rank.textColor = color.dark
        self.chinese.textColor = color.dark
        self.pinyin.textColor = color.dark
        self.translation.textColor = color.dark
    }

}
