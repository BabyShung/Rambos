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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(self.results?.count)
        
        self.results!.sort { $0.1 > $1.1}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! NumberDurationCollectionViewCell
        cell.numberLabel.text = results![indexPath.row].0
        cell.durationLabel.text = results![indexPath.row].1
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results!.count
    }

}
