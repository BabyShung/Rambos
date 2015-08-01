//
//  ObserverProxy.swift
//  Rambos
//
//  Created by Hao Zheng on 7/31/15.
//  Copyright (c) 2015 Planhola.com. All rights reserved.
//

import Foundation
@objc class ObserverProxy {
    
    var closure: (NSNotification) -> ()
    var name: String
    var object: AnyObject?
    
    init(name: String, closure: (NSNotification) -> ()) {
        self.closure = closure
        self.name = name
        self.start()
    }
    
    convenience init(name: String, object: AnyObject, closure: (NSNotification) -> ()) {
        self.init(name: name, closure: closure)
        self.object = object
    }
    
    deinit {
        stop()
    }
    
    func start() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"handler:", name:name, object: object)
    }
    
    func stop() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func handler(notification: NSNotification) {
        closure(notification)
    }
}