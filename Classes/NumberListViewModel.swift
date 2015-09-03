//
//  NumberListViewModel.swift
//  Rambos
//
//  Created by Hao Zheng on 8/20/15.
//  Copyright (c) 2015 Planhola.com. All rights reserved.
//

import Bond
import Foundation

class NumberListViewModel {
    
    let characterText = Dynamic<String>("")
    let buttonText = Dynamic<String>("Start")
    let timerText = Dynamic<String>("00:00:00")
    
    let statisticsButtonHidden = Dynamic<Bool>(true)

    var timer = ZHTimer()
    private var numberQueue = Queue<String>()
    var resultList : [(number:String,durationText:String,duration:Double)] = []
    
    init(){
        
        prepareNumbersQueue()
        
        timer.listener = {
            name in self.timerText.value = name
        }
    }
    
    /**
      Prepare shuffled numbers from 0 to 99
    */
    func prepareNumbersQueue(){
        var numbers = [String]()
        for i in 0 ... 9 {
            for j in 0 ... 9 {
                var current = String(i)
                current += String(j)
                numbers.append(current)
            }
        }
        numbers.shuffle()
        for number in numbers {
            self.numberQueue.enqueue(number)
        }
    }
    
    func reset() {
        timer.stop()
        self.timerText.value = "Finished!"
        self.characterText.value = ""
        self.buttonText.value = "Start Again"
        statisticsButtonHidden.value = false
        prepareNumbersQueue()
    }
    
    func getNumbers(howManyNumbers : Int) {
        
        if self.numberQueue.isEmpty() {
            //Done
            self.resultList += [(self.characterText.value,
                                     self.timerText.value,
                                            self.timer.elapsedTime)]
            
            reset()
            return
        }
        
        //get strings from the queue
        var actualLoop = howManyNumbers / 2
        var numberText = String()
        for index in 1 ... actualLoop {
            if !numberQueue.isEmpty() {
                numberText += numberQueue.dequeue()
            } else {
                break
            }
        }
        
        if timer.isStopped {    //first time
            self.resultList = []
            self.buttonText.value = "Next"
            statisticsButtonHidden.value = true
        } else {
            timer.stop()
            self.resultList += [(self.characterText.value,
                self.timerText.value,
                self.timer.elapsedTime)]
        }
        
        self.characterText.value = numberText
        timer.start()
        
    }
    
    func queueIsEmpty() -> Bool {
        return self.numberQueue.isEmpty()
    }
}