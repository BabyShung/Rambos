//
//  NumberDurationCollectionViewCell.swift
//  Rambos
//
//  Created by Hao Zheng on 8/22/15.
//  Copyright (c) 2015 Planhola.com. All rights reserved.
//

import UIKit

class NumberDurationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.cornerRadius = 5.0
    }
}
