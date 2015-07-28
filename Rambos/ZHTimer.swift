//
//  ZHTimer.swift
//  Rambers
//
//  Created by Hao Zheng on 7/26/15.
//  Copyright (c) 2015 Alarm.com. All rights reserved.
//

import Foundation

class ZHTimer {
    
    typealias Listener = String -> ()
    var listener: Listener?
    
    private var startTime = NSTimeInterval()
    private var timer:NSTimer
    
    var elapsedTimeString:String
    var isStopped:Bool {
        return !timer.valid
    }
    
    init() {
        timer = NSTimer()
        elapsedTimeString = "00:00:00"
    }
    
    convenience init(_ listener: Listener) {
        self.init()
        self.listener = listener
    }
    
    func start() {
        if (!timer.valid) {
            let aSelector : Selector = "updateTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
        }
    }
    
    func stop() {
        timer.invalidate()
    }
    
    /**
    This is called from NSTimer, should include @objc since this class is not NSObject
    */
    @objc func updateTime() {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        elapsedTimeString = "\(strMinutes):\(strSeconds):\(strFraction)"
        listener?(elapsedTimeString)
    }
}