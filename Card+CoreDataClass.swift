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
    
    convenience init(rank: Int, front: String, back: String, context: NSManagedObjectContext){
        let entity = NSEntityDescription.entity(forEntityName: "Card", in: context)!
        self.init(entity: entity, insertInto: context)
        self.rank = rank
        self.front = front
        self.back = back
        self.flipped = false
        self.deck = 0
        self.lastReviewed = nil
        
    }
    
    func flip() -> String {
        if flipped {
            return front!
        } else {
            return back!
        }
    }
    
    
}
