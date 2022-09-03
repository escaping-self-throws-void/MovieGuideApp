//
//  CalendarService.swift
//  MBC Movie Guide
//
//  Created by Paul Matar on 22/07/2022.
//
//
import UIKit
import EventKit

final class CalendarService {
    
    static let shared = CalendarService()
    
    var is24: Bool = true
    
    private init() {}
    
    func checkPermission(startDate: Date, duration: Double, eventName: String) -> Bool {
        let eventStore = EKEventStore()
        switch EKEventStore.authorizationStatus(for: .event) {
        case .notDetermined:
            eventStore.requestAccess(to: .event) { status, error in
                status ? self.insertEvent(store: eventStore, startDate: startDate, duration: duration, eventName: eventName)
                : print(error?.localizedDescription ?? "No localized error description")
            }
            return true
        case .restricted:
            print("Calendar access restricted")
            return false
        case .denied:
            print("Calendar access restricted")
            return false
        case .authorized:
            insertEvent(store: eventStore, startDate: startDate, duration: duration, eventName: eventName)
            return true
        @unknown default:
            print("Calendar access unknown issue")
            return false
        }
    }
    
    private func insertEvent(store: EKEventStore, startDate: Date, duration: Double, eventName: String) {
        let calendars = store.calendars(for: .event)
        for calendar in calendars {
            if calendar.title == "Calendar" {
                let event = EKEvent(eventStore: store)
                event.calendar = calendar
                event.startDate = startDate
                event.title = eventName
                event.endDate = event.startDate.addingTimeInterval(60*duration)
                let reminder = EKAlarm(relativeOffset: -60*30)
                event.alarms = [reminder]
                do {
                    try store.save(event, span: .thisEvent)
                    print("event inserted")
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
