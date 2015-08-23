//
//  NumberDurationViewController.swift
//  Rambos
//
//  Created by Hao Zheng on 8/22/15.
//  Copyright (c) 2015 Planhola.com. All rights reserved.
//

import UIKit

class NumberDurationViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var results : [(number: String, duration: String)]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! NumberDurationCollectionViewCell
        cell.numberLabel.text = "444"
        cell.durationLabel.text = "01:00:00"
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

}
