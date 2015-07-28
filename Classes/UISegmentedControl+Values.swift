//
//  UISegmentedControl+Values.swift
//  Rambers
//
//  Created by Hao Zheng on 7/26/15.
//  Copyright (c) 2015 Alarm.com. All rights reserved.
//

import UIKit

enum SegmentedControlValue {
    case ValueLeft
    case ValueRight
    
    func getValue() -> Int {
        switch self {
        case .ValueLeft:
            return 26
        case .ValueRight:
            return 52
        }
    }
}

extension UISegmentedControl {
    
    func getSelectedValue() -> Int {
        return self.selectedSegmentIndex == 0 ?
            SegmentedControlValue.ValueLeft.getValue() :
            SegmentedControlValue.ValueRight.getValue()
    }
}