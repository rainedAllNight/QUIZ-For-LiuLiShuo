//
//  TimerHelper.swift
//  Quiz
//
//  Created by rainedAllNight on 2017/11/20.
//  Copyright © 2017年 luowei. All rights reserved.
//

import Foundation

extension Timer {
    public class func scheduleCommonModeTimer(repeatInterval interval: TimeInterval, handler: @escaping (Timer?) -> Void) -> Timer {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0, handler)!
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer
    }
}
