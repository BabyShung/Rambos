//
//  NumberListViewController.swift
//  Rambos
//
//  Created by Hao Zheng on 8/18/15.
//  Copyright (c) 2015 Planhola.com. All rights reserved.
//

import Bond
import UIKit

class NumberListViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var charactersLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let viewModel = NumberListViewModel()
    let options = [2, 4, 6, 8, 10]
    
    //Actions
    lazy var startAndNextButtonObserver: Bond<UIControlEvents> = Bond<UIControlEvents> {
        [unowned self] event in
        
        if self.viewModel.queueIsEmpty() {
            
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("NumberDurationViewController") as! NumberDurationViewController
            //pass the data
//            vc.tuple = (self.randomNumberLabel.text!, self.timerLabel.text!)
            
            vc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            self.presentViewController(vc, animated: true, completion: nil)
            
        } else {
            var row = self.pickerView.selectedRowInComponent(0)
            var howManyNumbers = self.options[row]
            self.viewModel.getNumbers(howManyNumbers)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.themeWithColor(UIColor.darkTextColor())

        viewModel.timerText ->> timerLabel
        viewModel.buttonText ->> nextButton.dynTitle
        viewModel.characterText ->> charactersLabel
        
        nextButton.dynEvent.filter(==, .TouchUpInside) ->| startAndNextButtonObserver
        
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(options[row])"
    }
    
    func showActionSheetTapped() {
        let actionSheetController = UIAlertController(title: "Congrats", message: "You got this!", preferredStyle: .ActionSheet)
        
        actionSheetController.addAction(UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            })
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Statistics", style: .Default) { action -> Void in
        }
        actionSheetController.addAction(takePictureAction)
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Save", style: .Default) { action -> Void in
        }
        actionSheetController.addAction(choosePictureAction)
        
        //We need to provide a popover sourceView when using it on iPad
        //actionSheetController.popoverPresentationController?.sourceView = sender as UIView;
        
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
}
