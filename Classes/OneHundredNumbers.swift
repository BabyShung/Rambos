//
//  OneHundredNumbers.swift
//  Rambos
//
//  Created by Hao Zheng on 8/20/15.
//  Copyright (c) 2015 Planhola.com. All rights reserved.
//

import Foundation

class OneHundredNumbers {
    
    var index:Int
    var numbers:[Int]
    
    init() {
        index = 0
        numbers = [Int]()
        numbers += 0 ... 99
        numbers.shuffle()
    }
    
    func retrieve() -> Int? {
        if index >= numbers.count {
            return nil
        }
        return numbers[index++]
    }
}