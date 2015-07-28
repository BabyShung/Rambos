//
//  RandomNumbers.swift
//  Rambers
//
//  Created by Hao Zheng on 7/26/15.
//  Copyright (c) 2015 Alarm.com. All rights reserved.
//

import Foundation

class RandomNumbers {
    
    func randomNumberForDigits(digits: Int) -> String {
        
        var result = ""
        for i in 0 ..< digits {
            
            var randomNumer = Int(arc4random_uniform(10))
            result += String(randomNumer)
        }
        return result
    }
}