//
//  EnterResultViewController.swift
//  Rambos
//
//  Created by Hao Zheng on 7/28/15.
//  Copyright (c) 2015 Planhola.com. All rights reserved.
//

import UIKit
import Bond

class EnterResultViewController: UIViewController {

    @IBOutlet weak var resultTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var bottomViewBottomPadding: NSLayoutConstraint!
    
    var tuple : (correctString : String, usedTimeString : String)?
    
    let viewModel = EnterResultViewModel()
    
    lazy var confirmButtonTapObserver: Bond<UIControlEvents> = Bond<UIControlEvents> {
        [unowned self] event in
        
        if let two = self.tuple {
            self.viewModel.confirm((two.correctString, self.resultTextField.text))
        }
        
    }
    
    lazy var dismissButtonTapObserver: Bond<UIControlEvents> = Bond<UIControlEvents> {
        [unowned self] event in
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        resultTextField.keyboardType = UIKeyboardType.NumberPad
        dismissBtn.themeWithColor(UIColor.darkGrayColor())
        confirmBtn.themeWithColor(UIColor.orangeColor())
        
        viewModel.resultLabelText ->> resultLabel
        viewModel.enterResultTextFieldText <->> resultTextField
        
        confirmBtn.dynEvent.filter(==, .TouchUpInside) ->| confirmButtonTapObserver
        dismissBtn.dynEvent.filter(==, .TouchUpInside) ->| dismissButtonTapObserver
        
        //subscribe to keyboard change
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardNotification:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        if let two = tuple {
            resultLabel.text = "You used: " + two.usedTimeString
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        resultTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    /**
    This is for bottom view moving up with keyboard
    */
    func keyboardNotification(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey]!.doubleValue
            let endFrame = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue()
     
            
            let hideKeyBoard = endFrame.origin.y == UIScreen.mainScreen().bounds.size.height
            
            if (hideKeyBoard) {
                self.bottomViewBottomPadding.constant = 0
            } else {
                self.bottomViewBottomPadding.constant = endFrame.size.height;
            }
            
            UIView.animateWithDuration(duration, animations: {
                self.view.layoutIfNeeded()
            }, completion: { finished in
                
            })
        }
    }
}
