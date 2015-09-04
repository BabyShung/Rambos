//
//  String+Additions.swift
//  Rambos
//
//  Created by Hao Zheng on 9/3/15.
//  Copyright (c) 2015 Planhola.com. All rights reserved.
//

import Foundation

/** Additions Extends String

*/
extension String {
    
    subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }
}