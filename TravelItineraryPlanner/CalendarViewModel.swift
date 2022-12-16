//
//  CalendarViewModel.swift
//  TravelItineraryPlanner
//
//  Created by Michelle’s Air on 10/12/2022.
//

import Foundation

class CalendarViewModel {
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    func dateString(_ date: Date) -> String {
        dateFormatter.dateFormat = ("dd LLL yyyy")
        return dateFormatter.string(from: date)
    }
    
    func dayMonth(_ date: Date) -> String {
        dateFormatter.dateFormat = ("dd LLL")
        return dateFormatter.string(from: date)
    }
    
    func yearString(_ date: Date) -> String {
        dateFormatter.dateFormat = ("yyyy")
        return dateFormatter.string(from: date)
    }
    
//    func plusMonth(_ date: Date) -> Date
//    {
//        return calendar.date(byAdding: .month, value: 1, to: date)!
//    }
    
//    func minusMonth(_ date: Date) -> Date
//    {
//        return calendar.date(byAdding: .month, value: -1, to: date)!
//    }
    
    func previouseDaysInMonth(_ date: Date) -> Int {
        
        let range = calendar.range(of: .day, in: .month, for: calendar.date(byAdding: .month, value: -1, to: date)!)!
        return range.count
    }
    
    func daysInMonth(_ date: Date) -> Int
    {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
//    func nextDaysInMonth(_ date: Date) -> Int {
//
//        let range = calendar.range(of: .day, in: .month, for: calendar.date(byAdding: .month, value: 1, to: date)!)!
//        return range.count
//    }
    
    private func firstOfMonth(_ date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    // Thursday will return 4
    func weekDay(_ date: Date) -> Int
    {
        let components = calendar.dateComponents([.weekday], from: firstOfMonth(date))
        return components.weekday! - 1
    }
    // surely these can be extensions
    func day(_ date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    func month(_ date: Date) -> Int
    {
        let components = calendar.dateComponents([.month], from: firstOfMonth(date))
        return components.month!
    }
    
    
    func changeMonth(_ month: Int, _ date: Date) -> Date {
        return calendar.date(bySetting: .month, value: month, of: date)!
    }
    
    func changeDay(_ day: Day, _ date: Date) -> Date {
        
        var nextDate = date
        switch day.monthState {
        case .current:
            break
        case .next:
            nextDate = calendar.date(byAdding: .month, value: 1, to: date)!
        case .previous:
            nextDate = calendar.date(byAdding: .month, value: -1, to: date)!
        }
        
        var dateComponents: DateComponents? = calendar.dateComponents([.year, .month, .day, .second, .hour, .minute], from: nextDate)
        dateComponents?.day = day.value
        
        return calendar.date(from: dateComponents!)!
        
    }
}
