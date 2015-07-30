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
    
    let resultLabelText = Dynamic<String>("");
    let enterResultTextFieldText = Dynamic<String>("");
    
    func confirm(tuple : (correctString: String, inputString : String)) {
        if tuple.0 == tuple.1 {
            resultLabelText.value = "Congrat! You got the right answer!"
        } else {
            resultLabelText.value = "Sorry, it's wrong."
        }
        
    }
    
}