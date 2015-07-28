//
//  UIButton+Theme.swift
//  Rambers
//
//  Created by Hao Zheng on 7/26/15.
//  Copyright (c) 2015 Alarm.com. All rights reserved.
//

import UIKit

extension UIButton {
    
    func defaultStyle() {
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 6.0;
        self.layer.masksToBounds = true;
        self.adjustsImageWhenHighlighted = false;
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.setTitleColor(UIColor.whiteColor().colorWithAlphaComponent(0.3), forState: UIControlState.Disabled)
        self.titleLabel!.font = UIFont (name: "HelveticaNeue", size: self.titleLabel!.font.pointSize)
    }
    
    func themeWithColor(color : UIColor) {
        defaultStyle()
        self.backgroundColor = color
        self.layer.borderColor = color.colorWithAlphaComponent(0.7).CGColor
    }
}
