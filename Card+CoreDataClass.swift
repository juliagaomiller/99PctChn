//
//  Card+CoreDataClass.swift
//  99PctChn
//
//  Created by Julia Miller on 11/15/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import CoreData


public class Card: NSManagedObject {
    
    var rank: Int {
        get { return Int(int32rank) }
        set { int32rank = Int32(newValue) }
    }
    
    var deck: Int {
        get { return Int(int32deck) }
        set { int32deck = Int32(newValue) }
    }
    
    var front: [String: String] {
        return ["chinese": chinese!]
    }
    var back: [String: String?] {
        return ["translation": translation,
                "pinyin": pinyin,
                "example": example,
                "exampleTranslation": exampleTranslation
        ]
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
        self.deck = 0
        self.lastReviewed = nil
        
    }
    
    func flip() -> [String: String?] {
        if flipped {
            return front
        } else {
            return back
        }
    }

}
