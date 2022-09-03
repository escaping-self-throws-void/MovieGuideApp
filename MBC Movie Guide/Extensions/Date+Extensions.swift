//
//  Date+Extensions.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 16/07/2022.
//

import Foundation

extension Date {
    var birthdayText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        return formatter.string(from: self)
    }
    
    var popUpDayText: String {
        let formatter = DateFormatter()
        let isEn = LanguageService.shared.isEn
        formatter.locale = Locale(identifier: isEn ? C.Lang.en : C.Lang.ar)
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }
    
    var popUpMonthText: String {
        let formatter = DateFormatter()
        let isEn = LanguageService.shared.isEn
        formatter.locale = Locale(identifier: isEn ? C.Lang.en : C.Lang.ar)
        formatter.dateFormat = "MMMM"
        return formatter.string(from: self)
    }
    
    var barLabelText: String {
        let formatter = DateFormatter()
        let isEn = LanguageService.shared.isEn
        formatter.locale = Locale(identifier: isEn ? C.Lang.en : C.Lang.ar)
        formatter.dateFormat = "MMMM, d"
        return formatter.string(from: self)
    }
    
    var apiText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        formatter.locale = Locale(identifier: C.Lang.en)
        return formatter.string(from: self)
    }
    
    var timeText: String {
        let formatter = DateFormatter()
        let isEn = LanguageService.shared.isEn
        formatter.locale = Locale(identifier: isEn ? C.Lang.en : C.Lang.ar)
        formatter.dateFormat = CalendarService.shared.is24 ? "HH:mm" : "h:mm a"
        return formatter.string(from: self)
    }
    
    var isAvailableNow: Bool {
        let now = Date.now
        let hourBefor = now.addingTimeInterval(-60*60)
        let hourAfter = now.addingTimeInterval(60*60)
        let hourRange = hourBefor...hourAfter
        return hourRange.contains(self)
    }
    
    var releaseLabelText: String {
        let formatter = DateFormatter()
        let isEn = LanguageService.shared.isEn
        formatter.locale = Locale(identifier: isEn ? C.Lang.en : C.Lang.ar)
        formatter.dateFormat = "MMMM d, YYYY"
        return formatter.string(from: self)
    }
}

