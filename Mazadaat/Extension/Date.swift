//
//  Date.swift
//  Mazadaat
//
//  Created by Abdullah Tarek on 08/10/2023.
//  Copyright © 2023 macbook. All rights reserved.
//

import UIKit

extension String {
    func formattedCountdown(stop: Bool? = false, completion: @escaping (String) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.locale = Locale.current
        
        print(self)
        if let endDate = dateFormatter.date(from: self) {
            let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                
                if stop == true {
                    // Stop the timer and remove it from the run loop
                }
                
                let calendar = Calendar.current
                let components = calendar.dateComponents([.day, .hour, .minute, .second], from: Date(), to: endDate)
            
                var formattedString = "ending in "
                
                if endDate < Date() {
                    timer.invalidate()
                    TimerManager.stopTimer() 
                    formattedString = "expired".localize
                } else {
                    if let days = components.day, days > 0 {
                        formattedString += "\(days) d "
                    }
                    
                    if let hours = components.hour, hours > 0 {
                        formattedString += "\(hours) h "
                    }
                    
                    if let minutes = components.minute, minutes > 0 {
                        formattedString += "\(minutes) m "
                    }
                    
                    if let seconds = components.second, seconds > 0 {
                        formattedString += "\(seconds) s"
                    }
                }
                
                completion(formattedString)
            }
            
            // Fire the timer immediately
//            timer.fire()
            
            TimerManager.startTimer(timer: timer)
        }
    }
}

class TimerManager {
    static var runLoop: RunLoop?
    static var currentTimer: Timer?

    static func startTimer(timer: Timer) {
        // Store the run loop and timer instance
        runLoop = RunLoop.current
        currentTimer = timer
        runLoop?.add(timer, forMode: .common)
    }

    static func stopTimer() {
        // Remove the timer from the run loop
        currentTimer?.invalidate()
        runLoop?.cancelPerformSelectors(withTarget: currentTimer ?? Timer())
    }
}
