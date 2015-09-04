//
//  EnterResultViewModel.swift
//  Rambos
//
//  Created by Hao Zheng on 7/29/15.
//  Copyright (c) 2015 Planhola.com. All rights reserved.
//

import Foundation
import Bond

class EnterResultViewModel {
    
    let resultLabelText = Dynamic<NSAttributedString>(NSAttributedString(string:""));
    let enterResultTextFieldText = Dynamic<String>("");
    
    func confirm(tuple : (correctString: String, inputString : String)) {
        var cString = tuple.0.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        var iString = tuple.1.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if cString == iString {
            resultLabelText.value = NSAttributedString(string: "Congrat! You got the right answer!")
        } else {
            //resultLabelText.value = "Sorry, it's wrong."
            resultLabelText.value = NSAttributedString(string: "Sorry, it's wrong.")
            
            //update to Swift 2.0
            //resultLabelText.value = self.getComparedString(cString, inputString: iString)
        }
        
    }
    
    func getComparedString(correctString: String, inputString: String) -> NSAttributedString {
        
        var loopTimes : Int
        var correctLength = count(correctString)
        var inputLength = count(inputString)
        
        var muString = NSMutableAttributedString(string: correctString, attributes: [NSFontAttributeName:UIFont(name: "Helvetica Neue", size: 18.0)!])
        
        if correctLength > inputLength {
            loopTimes = inputLength
        } else {
            loopTimes = correctLength
        }
        
//        for index in 0 ..< loopTimes {
//            if (correctString[index] === inputString[index]) {
//                muString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSRange(location: 2, length: 4))
//                correctString.
//            }
//        }
        
        muString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSRange(location: 2, length: 4))
        muString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSRange(location: 0, length: 4))
        
        return muString
    }
    
}