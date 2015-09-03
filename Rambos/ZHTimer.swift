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
    var elapsedTime = NSTimeInterval()
    
    var isStopped:Bool {
        return !timer.valid
    }
    
    init() {
        timer = NSTimer()
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
        if let myListener = self.listener {
            myListener(formartElapsedTimeString(self.startTime))
        }
    }
    
    func formartElapsedTimeString(startTime:Double) -> String {
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime
        self.elapsedTime = elapsedTime
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
        
        return "\(strMinutes):\(strSeconds):\(strFraction)"
    }
    
    func roundToPlaces() -> Double {
        return self.roundToPlaces(self.elapsedTime, places: 2)
    }
    
    func roundToPlaces(value:Double, places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(value * divisor) / divisor
    }
}