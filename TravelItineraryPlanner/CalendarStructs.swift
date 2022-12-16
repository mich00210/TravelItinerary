//
//  CalendarStructs.swift
//  TravelItineraryPlanner
//
//  Created by Michelle’s Air on 11/12/2022.
//

import Foundation

struct Month: Identifiable {
    var id = UUID()
    var description: String
    
    init(_ description: String) {
        self.description = String(description[..<String.Index(encodedOffset: 3)])
    }
}

struct Weekday: Identifiable {
    var id = UUID()
    var name: String
    
    init(_ name: String){
        self.name = name
    }
}

struct Day {
    var value: Int
    var monthState: MonthState
    
    enum MonthState {
        case previous
        case current
        case next
    }
}


func setDays(_ days: [Int], _ monthState: Day.MonthState)-> [Day] {
    return days.map {
        .init(value: $0, monthState: monthState)
    }
}

enum Months: Int, CaseIterable {
    case January = 1
    case February
    case March
    case April
    case May
    case June
    case July
    case August
    case September
    case October
    case November
    case December
    
    var description: String {
        let name = "\(self)"
        return String(name[..<String.Index(encodedOffset: 3)])
    }
    
    var fullName: String {
        return "\(self)"
    }
}
