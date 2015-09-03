//
//  RandomNumbersViewController.swift
//  Rambers
//
//  Created by Hao Zheng on 7/26/15.
//  Copyright (c) 2015 Alarm.com. All rights reserved.
//

import UIKit
import Bond

class RandomNumbersViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var randomNumberLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    //view model
    let viewModel = RandomNumberViewModel()
    
    let options = [26, 52, 80, 150, 200]
    
    //Actions
    lazy var startButtonTapObserver: Bond<UIControlEvents> = Bond<UIControlEvents> {
        [unowned self] event in
        self.viewModel.digitNumbers = self.options[self.pickerView.selectedRowInComponent(0)]
        self.viewModel.startTimer()
        self.pickerView.hidden = true
    }
    
    lazy var stopButtonTapObserver: Bond<UIControlEvents> = Bond<UIControlEvents> {
        [unowned self] event in
        self.viewModel.stopTimer()
        self.pickerView.hidden = false
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("EnterResultViewController") as! EnterResultViewController
        //pass the data
        vc.tuple = (self.randomNumberLabel.text!, self.timerLabel.text!)
        
        vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(vc, animated: true) { () -> Void in
            self.randomNumberLabel.text = ""
        }
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
        viewModel.randomNumberLabelHidden ->> randomNumberLabel.dynHidden
        
        viewModel.startButtonEnabled ->> startButton
        viewModel.stopButtonEnabled ->> stopButton
        
        startButton.dynEvent.filter(==, .TouchUpInside) ->| startButtonTapObserver
        stopButton.dynEvent.filter(==, .TouchUpInside) ->| stopButtonTapObserver
    }
    
    /**
    Picker View delegates
    */
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(options[row]) digits"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
