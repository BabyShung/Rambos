//
//  RandomNumbersViewController.swift
//  Rambers
//
//  Created by Hao Zheng on 7/26/15.
//  Copyright (c) 2015 Alarm.com. All rights reserved.
//

import UIKit
import Bond

class RandomNumbersViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var digitsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var randomNumberLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var averageTimeLabel: UILabel!
    
    //view model
    let viewModel = RandomNumberViewModel()
    
    //Actions
    lazy var startButtonTapObserver: Bond<UIControlEvents> = Bond<UIControlEvents> {
        [unowned self] event in
        self.viewModel.startTimer()
    }
    
    lazy var stopButtonTapObserver: Bond<UIControlEvents> = Bond<UIControlEvents> {
        [unowned self] event in
        self.viewModel.stopTimer()
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("EnterResultViewController") as! EnterResultViewController
        //pass the data
        vc.tuple = (self.randomNumberLabel.text!, self.timerLabel.text!)
        
        vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(vc, animated: true, completion: nil)
    }
        
    /**
    Life cycle
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.themeWithColor(UIColor.orangeColor())
        stopButton.themeWithColor(UIColor.blueColor())
        
        viewModel.randomNumberText ->> randomNumberLabel
        viewModel.timerText ->> timerLabel
        viewModel.averageTimeText ->> averageTimeLabel
        
        viewModel.startButtonEnabled ->> startButton
        viewModel.stopButtonEnabled ->> stopButton
        
        startButton.dynEvent.filter(==, .TouchUpInside) ->| startButtonTapObserver
        stopButton.dynEvent.filter(==, .TouchUpInside) ->| stopButtonTapObserver
    }

    @IBAction func segmentedValueChanged(sender: UISegmentedControl) {
            self.viewModel.digitNumbers = sender.getSelectedValue()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
