//
//  Queue.swift
//  Rambos
//
//  Created by Hao Zheng on 8/21/15.
//  Copyright (c) 2015 Planhola.com. All rights reserved.
//

import Foundation

struct Queue<T> {
    var elements = [T]()
    
    mutating func enqueue(element: T){
        elements.insert(element, atIndex: 0)
    }
    
    mutating func dequeue() -> T {
        return elements.removeLast()
    }
    
    func front() -> T {
        return elements[elements.endIndex - 1]
    }
    
    func back() -> T{
        return elements[0]
    }
    
    func isEmpty() -> Bool {
        return elements.count == 0 ? true : false;
    }
    
    var size: Int {
        return elements.count
    }
}
