//
//  Array+Additions.swift
//  Rambos
//
//  Created by Hao Zheng on 8/22/15.
//  Copyright (c) 2015 Planhola.com. All rights reserved.
//

import Foundation

/** Additions Extends Array

*/
extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
