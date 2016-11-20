//
//  Card+CoreDataClass.swift
//  99PctChn
//
//  Created by Julia Miller on 11/15/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import CoreData
import UIKit


public class Card: NSManagedObject {
    
    var rank: Int {
        get { return Int(int32rank) }
        set { int32rank = Int32(newValue) }
    }
    
    var deck: Int {
        get { return Int(int32deck) }
        set { int32deck = Int32(newValue) }
    }
    
    convenience init(rank: Int, chinese: String, pinyin: String, translation: String, example: String?, exampleTranslation: String?, context: NSManagedObjectContext){
        let entity = NSEntityDescription.entity(forEntityName: "Card", in: context)!
        self.init(entity: entity, insertInto: context)
        self.rank = rank
        self.chinese = chinese
        self.pinyin = pinyin
        self.translation = translation
        self.example = example
        self.exampleTranslation = exampleTranslation
        self.flipped = false
        self.deck = -1
        self.lastReviewed = nil
        
    }
    
    func returnColor() -> (dark: UIColor, light: UIColor) {
        let h = Helper()
        switch(self.deck) {
        case 0:
            return (h.darkBrown, h.lightBrown)
        case 1:
            return (h.darkRed, h.lightRed)
        case 2:
            return (h.darkYellow, h.lightYellow)
        case 3:
            return (h.darkGreen, h.lightGreen)
        case 4:
            return (h.darkBlue, h.lightBlue)
        default:
            fatalError("Deck index out of range: \(self.deck)")
        }
    }

}
