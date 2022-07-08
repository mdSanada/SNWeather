//
//  TimerHelper.swift
//  SNWeather
//
//  Created by Matheus D Sanada on 05/07/22.
//

import Foundation

class DateHelper {
    private static func dateFormatter(secondsFromGMT: Int, pattern: String = "HH:mm") -> DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: secondsFromGMT)
        formatter.locale = .current
        formatter.dateFormat = pattern
        return formatter
    }
    
    internal static func getDate(secondsFromGMT: Int, pattern: String = "HH:mm") -> String {
        let date = Date()
        let formatter = dateFormatter(secondsFromGMT: secondsFromGMT, pattern: pattern)
        return formatter.string(from: date)
    }
    
    internal static func secondsToMinutes() -> Double {
        let date = Date()
        let calendar = Calendar.current
        let seconds = calendar.component(.second, from: date)
        let deltaSeconds: Double = Double(60 - seconds)
        print(deltaSeconds)
        return (deltaSeconds < 0 ? 0 : deltaSeconds)
    }
    
    internal static func getDate(timeIntervalSince1970: Int, secondsFromGMT: Int, pattern: String = "HH:mm") -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timeIntervalSince1970))
        let formatter = dateFormatter(secondsFromGMT: secondsFromGMT, pattern: pattern)
        return formatter.string(from: date)
    }
}
