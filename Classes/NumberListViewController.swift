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
    
    @IBOutlet weak var statisticsButton: UIButton!
    
    var selectedPickerIndex:Int! = 0
    let viewModel = NumberListViewModel()
    let options = [2, 4, 6, 8, 10]
    
    @IBAction func didClickNextButton(sender: AnyObject) {
        
        self.pickerView.hidden = true
        var howManyNumbers = self.options[self.selectedPickerIndex]
        self.viewModel.getNumbers(howManyNumbers)
    }
    
    @IBAction func didClickStatistics(sender: AnyObject) {
        showStatisticsView()
    }
    
    func showStatisticsView() {
        
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("NumberDurationViewController") as! NumberDurationViewController
        //pass the data
        vc.results = self.viewModel.resultList
        
        self.viewModel.prepareNumbersQueue()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedPickerIndex = self.pickerView.selectedRowInComponent(0)
        
        nextButton.themeWithColor(UIColor.darkTextColor())
        
        viewModel.statisticsButtonHidden ->> statisticsButton.dynHidden
        viewModel.timerText ->> timerLabel
        viewModel.buttonText ->> nextButton.dynTitle
        viewModel.characterText ->> charactersLabel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        return "\(options[row]) numbers"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedPickerIndex = row
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
