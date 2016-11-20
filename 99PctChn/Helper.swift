//
//  File.swift
//  99PctChn
//
//  Created by Julia Miller on 11/15/16.
//  Copyright © 2016 Julia Miller. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
//    static let darkRed = UIColor(red:0.99, green:0.51, blue:0.44, alpha:1.0)
//    static let lightRed = UIColor(red:0.99, green:0.68, blue:0.71, alpha:1.0)
//    static let darkYellow = UIColor(red:1.00, green:0.80, blue:0.40, alpha:1.0)
//    static let lightYellow = UIColor(red:1.00, green:0.96, blue:0.67, alpha:1.0)
//    static let darkGreen = UIColor(red:0.50, green:0.91, blue:0.39, alpha:1.0)
//    static let lightGreen = UIColor(red:0.71, green:1.00, blue:0.73, alpha:1.0)
//    static let darkBlue = UIColor(red:0.36, green:0.89, blue:0.88, alpha:1.0)
//    static let lightBlue = UIColor(red:0.64, green:0.98, blue:0.97, alpha:1.0)
//    static let lightBrown = UIColor(red:0.92, green:0.82, blue:0.62, alpha:1.0)
//    static let darkBrown = UIColor(red:0.46, green:0.33, blue:0.18, alpha:1.0)
}

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (unshuffledCount, firstUnshuffled) in zip(stride(from: c, to: 1, by: -1), indices) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

extension Array {
    
    func chooseRandom() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count-1)))
        return self[index]
    }
    
    func split() -> [[Element]] {
        let ct = self.count
        let half = ct / 2
        let leftSplit = self[0 ..< half]
        let rightSplit = self[half ..< ct]
        return [Array(leftSplit), Array(rightSplit)]
    }
}

extension Array where Element: Equatable {
    func removeDuplicates() -> [Element] {
        var unique = [Element]()
        for i in self{
                if !unique.contains(i){
                    unique.append(i)
                }
        }
        return unique
    }
    
    mutating func removeElement(item: Element) {
        for x in self {
            var i = 0
            while i < self.count {
                if x == item {
                    self.remove(at: i)
                } else {
                    i += 1
                }
            }
            
        }
    }
}

class Helper {
    //let darkGrey, lightGrey, backgroundGrey: UIColor!
    let darkBrown, lightBrown: UIColor!
    let darkRed, lightRed: UIColor!
    let darkYellow, lightYellow: UIColor!
    let darkGreen, lightGreen: UIColor!
    let darkBlue, lightBlue: UIColor!
    
    
    init(){
        darkBrown = UIColor(red:0.46, green:0.33, blue:0.18, alpha:1.0)
        lightBrown = UIColor(red:0.92, green:0.82, blue:0.62, alpha:1.0)
        darkRed = UIColor(red:0.99, green:0.51, blue:0.44, alpha:1.0)
        lightRed = UIColor(red:0.99, green:0.68, blue:0.71, alpha:1.0)
        darkYellow = UIColor(red:1.00, green:0.80, blue:0.40, alpha:1.0)
        lightYellow = UIColor(red:1.00, green:0.96, blue:0.67, alpha:1.0)
        darkGreen = UIColor(red:0.50, green:0.91, blue:0.39, alpha:1.0)
        lightGreen = UIColor(red:0.71, green:1.00, blue:0.73, alpha:1.0)
        darkBlue = UIColor(red:0.36, green:0.89, blue:0.88, alpha:1.0)
        lightBlue = UIColor(red:0.64, green:0.98, blue:0.97, alpha:1.0)
    }
}
