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
    
    let viewModel = RandomNumberViewModel()
    
    lazy var startButtonTapObserver: Bond<UIControlEvents> = Bond<UIControlEvents> {
        [unowned self] event in
        self.viewModel.startTimer()
    }
    
    lazy var stopButtonTapObserver: Bond<UIControlEvents> = Bond<UIControlEvents> {
        [unowned self] event in
        self.viewModel.stopTimer()
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
