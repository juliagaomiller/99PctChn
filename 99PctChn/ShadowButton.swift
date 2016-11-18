//
//  ShadowButton.swift
//  99PctChn
//
//  Created by Julia Miller on 11/17/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import UIKit

class ShadowButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = false
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
    }

    

}
