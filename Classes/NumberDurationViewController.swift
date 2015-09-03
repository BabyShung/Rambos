//
//  NumberDurationViewController.swift
//  Rambos
//
//  Created by Hao Zheng on 8/22/15.
//  Copyright (c) 2015 Planhola.com. All rights reserved.
//

import UIKit

class NumberDurationViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var results : [(number: String, durationText: String, duration: Double)]?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(self.results?.count)
        println(self.results)
        self.results!.sort { $0.1 > $1.1}
        
        //sum all durations
        var count = 0.0
        for row in self.results! {
            count += row.2
        }
        self.title = String(format: "%.2f seconds", count)
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
