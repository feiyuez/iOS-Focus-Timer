//
//  TimerModel.swift
//  Focus Timer
//
//  Created by Feiyue Zhang on 3/13/21.
//

import Foundation
import Combine
import SwiftUI

class TimerModel: ObservableObject {
    @Published var type: TimerType = .focus
    @Published var status: TimerStatus = .initial
    @Published var secondsLeft = UserDefaults.standard.integer(forKey: "secondsOfFocus")
    @Published var sessionsLeft = UserDefaults.standard.integer(forKey: "numOfSessions")
    @Published var completedFocus = 0
    
    var timer = Timer()
    
    func setTimer(focus: Int, relax: Int, sessions: Int) {
        let defaults = UserDefaults.standard

//        defaults.set(focus, forKey: "secondsOfFocus")
//        defaults.set(relax, forKey: "secondsOfRelax")
//        defaults.set(sessions, forKey: "numOfSessions")
//        secondsLeft = focus
        defaults.set(focus * 60, forKey: "secondsOfFocus")
        defaults.set(relax * 60, forKey: "secondsOfRelax")
        defaults.set(sessions, forKey: "numOfSessions")
        secondsLeft = focus * 60
    }
    
    func start() {
        status = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            self.secondsLeft -= 1
            if self.secondsLeft == 0 {
                self.addNotification(type: self.type)
                self.sessionsLeft -= 1
                if self.sessionsLeft == 0 {
                    timer.invalidate()
                    self.status = .over
                } else {
                    if self.type == .focus {
                        self.completedFocus += 1
                    }
                    self.secondsLeft = self.type == .focus ? UserDefaults.standard.integer(forKey: "secondsOfRelax") : UserDefaults.standard.integer(forKey: "secondsOfFocus")
                    self.type = self.type == .focus ? .relax : .focus
                }
            }
        })
    }
    
    func addNotification(type: TimerType) {
        let content = UNMutableNotificationContent()
        content.title = "Time is up!"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func pause() {
        status = .paused
        timer.invalidate()
    }
    
    func skip() {
        self.type = .focus
        self.secondsLeft = UserDefaults.standard.integer(forKey: "secondsOfFocus")
    }
    
    enum TimerType {
        case focus
        case relax
    }
    
    enum TimerStatus {
        case initial
        case paused
        case running
        case over
    }
}
