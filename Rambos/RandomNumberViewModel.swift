//
//  RandomNumberViewModel.swift
//  Rambers
//
//  Created by Hao Zheng on 7/26/15.
//  Copyright (c) 2015 Alarm.com. All rights reserved.
//

import Bond
import Foundation

class RandomNumberViewModel {
    
    let timerText = Dynamic<String>("00:00:00")
    let randomNumberText = Dynamic<String>("Get Ready..")
    let randomNum = RandomNumbers()
    let randomNumberLabelHidden = Dynamic<Bool>(true)
    
    var digitNumbers:Int = 26
    var startButtonEnabled: Dynamic<Bool>
    var stopButtonEnabled: Dynamic<Bool>
    var timer = ZHTimer()
    
    init(){
        startButtonEnabled = Dynamic<Bool>(true)//default to enable
        stopButtonEnabled = Dynamic<Bool>(!startButtonEnabled.value)
        
        timer.listener = {
            name in self.timerText.value = name
        }
    }

    func startTimer() {
        timer.start()
        startButtonEnabled.value = false
        stopButtonEnabled.value = true
        randomNumberLabelHidden.value = false
        randomNumberText.value = randomNum.randomNumberForDigits(digitNumbers)
    }
    
    func stopTimer() {
        timer.stop()
        startButtonEnabled.value = true
        stopButtonEnabled.value = false
    }
}
