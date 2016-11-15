//
//  Card+CoreDataProperties.swift
//  99PctChn
//
//  Created by Julia Miller on 11/15/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card");
    }

    @NSManaged public var front: String?
    @NSManaged public var back: String?
    @NSManaged public var rank: Int32
    @NSManaged public var deck: Int32
    @NSManaged public var flipped: Bool
    @NSManaged public var lastReviewed: NSDate?

}
