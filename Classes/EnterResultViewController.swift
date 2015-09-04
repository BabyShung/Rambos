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

    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var bottomViewBottomPadding: NSLayoutConstraint!
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    var tuple : (correctString : String, usedTimeString : String)?
    var observer : ObserverProxy?
    
    let viewModel = EnterResultViewModel()
    
    lazy var confirmButtonTapObserver: Bond<UIControlEvents> = Bond<UIControlEvents> {
        [unowned self] event in
        if let two = self.tuple {
            self.viewModel.confirm((two.correctString, self.resultTextView.text))
        }
    }
    
    lazy var dismissButtonTapObserver: Bond<UIControlEvents> = Bond<UIControlEvents> {
        [unowned self] event in
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultTextView.keyboardType = UIKeyboardType.NumberPad
        dismissBtn.themeWithColor(UIColor.darkGrayColor())
        confirmBtn.themeWithColor(UIColor.orangeColor())
        
        viewModel.resultLabelText ->> resultLabel.dynAttributedText
        viewModel.enterResultTextFieldText <->> resultTextView
        
        confirmBtn.dynEvent.filter(==, .TouchUpInside) ->| confirmButtonTapObserver
        dismissBtn.dynEvent.filter(==, .TouchUpInside) ->| dismissButtonTapObserver
        
        self.registerKeyboardWillChange()
        
        if let two = tuple {
            resultLabel.text = "You used: " + two.usedTimeString
        }
    }
    
    /**
    This is for bottom view moving up with keyboard
    */
    func registerKeyboardWillChange() {
        observer = ObserverProxy(name: UIKeyboardWillChangeFrameNotification, closure: {
            [unowned self] sender in
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
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        resultTextView.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
