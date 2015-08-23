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

    var timer = ZHTimer()
    private var numberQueue = Queue<Int>()
    var resultList : [(number:String,duration:String)] = []
    
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
        var numbers = [Int]()
        numbers += 0 ... 99
        numbers.shuffle()
        for number in numbers {
            self.numberQueue.enqueue(number)
        }
    }
    
    func getNumbers(howManyNumbers : Int) {
        timer.stop()
        self.buttonText.value = "Next"
        
        println(howManyNumbers)
        
        var numberText = String()
        for index in 1 ... howManyNumbers {
            if !numberQueue.isEmpty() {
                numberText += "\(numberQueue.dequeue())"
            } else {
                break
            }
            println("---")
        }
        
        if numberQueue.isEmpty() {
            timer.stop()
            prepareNumbersQueue()
            self.timerText.value = "Finished!"
            self.characterText.value = ""
            self.buttonText.value = "Start"
            self.resultList = []
        } else {
            self.resultList += [(numberText, self.timerText.value)]
            self.characterText.value = numberText
            timer.start()
        }
    }
    
    func queueIsEmpty() -> Bool {
        return self.numberQueue.isEmpty()
    }
}