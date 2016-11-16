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

    @NSManaged public var chinese: String?
    @NSManaged public var pinyin: String?
    @NSManaged public var int32rank: Int32
    @NSManaged public var int32deck: Int32
    @NSManaged public var flipped: Bool
    @NSManaged public var lastReviewed: NSDate?
    @NSManaged public var translation: String?
    @NSManaged public var example: String?
    @NSManaged public var exampleTranslation: String?

}
