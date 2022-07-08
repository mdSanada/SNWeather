//
//  TimerHelper.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 05/07/22.
//

import Foundation

class TimerHelper {
    static internal func stopTimer(_ timer: inout Timer?) {
        timer?.invalidate()
        timer = nil
    }
    
    static internal func configureTimer(timer: @escaping ((Timer) -> ()), handler: @escaping (() -> ())) {
        DispatchQueue.main.asyncAfter(deadline: .now() + DateHelper.secondsToMinutes()) {
            handler()
            let innerTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { timer in
                handler()
            })
            timer(innerTimer)
        }
    }
}
