//
//  CalendarView.swift
//  TravelItineraryPlanner
//
//  Created by Michelle’s Air on 9/12/2022.
//

import SwiftUI

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
let titleColor: Color = Color(uiColor: UIColor(named: "PrimaryColor")!)
let accentColor: Color = Color(uiColor: UIColor(named: "AccentColor")!)
let secondaryColor: Color = Color(uiColor: UIColor(named: "PrimaryColorLight")!)
let accentColorLight: Color = Color(uiColor: UIColor(named: "AccentColorLight")!)

struct CalendarView: View {
    @EnvironmentObject var dateHolder: DateHolder
    

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
//            Text(CalendarViewModel().dateString(dateHolder.date))
            Text("2023")
                .bold()
                .font(.largeTitle)
                .foregroundColor(titleColor)
            ScrollViewReader { value in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Months.allCases, id: \.self){ month in
                            Button(action: {
                                dateHolder.date = CalendarViewModel().changeMonth(month.rawValue, dateHolder.date)
                                withAnimation(.easeInOut(duration: 1)) {
                                    value.scrollTo(month.rawValue)
                                }
                            }) {
                                VStack(spacing: 0) {
                                    let currMonth = month.rawValue == CalendarViewModel().month(dateHolder.date)
                                    
                                    Text("\(month.description)".uppercased())
                                        .bold()
                                        .foregroundColor(currMonth ? .primary : .secondary)
                                        .font(.title2)
                                        
                                    if currMonth {
                                        Capsule()
                                            .frame(width: 20, height: 3)
                                            .foregroundColor(titleColor)
                                    }
                                }
                                
                                Spacer()
                                    .frame(width: 48)
                            }
                            .id(month.rawValue)
                        }
                    }
                    
                }
                .padding(.vertical, 8)
                .onAppear(perform: {value.scrollTo(CalendarViewModel().month(dateHolder.date))})
                days
                calendarGrid(scrollValue: value)
                    .frame(width: 306,height: 204)
//                    .padding(.vertical, 30)
                
                
                }
            VStack(alignment: .leading, spacing: 12) {
                Text("Countries")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(titleColor)
                ScrollView(.horizontal, showsIndicators: false) {
                    Line()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                        .frame(height: 1)
                    Spacer()
                        .frame(height: 24)
                    HStack(spacing: 15) {
                        RoundedRectangle(cornerSize: .init(width: 5, height: 5))
                            .foregroundColor(titleColor)
                            .frame(width: 150)
                        RoundedRectangle(cornerSize: .init(width: 5, height: 5))
                            .foregroundColor(accentColorLight)
                            .frame(width: 150)
                        RoundedRectangle(cornerSize: .init(width: 5, height: 5))
                            .foregroundColor(accentColorLight)
                            .frame(width: 150)
                    }
                }
                Spacer()
            }
            
        }
    }
    

    
    var days: some View {
        LazyVGrid(columns: [
            GridItem(.fixed(40)),
            GridItem(.fixed(40)),
            GridItem(.fixed(40)),
            GridItem(.fixed(40)),
            GridItem(.fixed(40)),
            GridItem(.fixed(40)),
            GridItem(.fixed(40))
            
        ]) {
            let days: [Weekday] = [.init("M"),
                               .init("T"),
                               .init("W"),
                               .init("T"),
                               .init("F"),
                               .init("S"),
                               .init("S")]
            ForEach(days, id: \.id) { day in
                Text(day.name).bold()
                        }
                    }
    }
    
    func calendarGrid(scrollValue: ScrollViewProxy) -> some View {
        LazyVGrid(columns: [
            GridItem(.fixed(40)),
            GridItem(.fixed(40)),
            GridItem(.fixed(40)),
            GridItem(.fixed(40)),
            GridItem(.fixed(40)),
            GridItem(.fixed(40)),
            GridItem(.fixed(40))
            
        ], spacing: 0) {
            
            // Make array of days
            let firstDay = CalendarViewModel().weekDay(dateHolder.date)
            
            // start dates
            let prevNumberOfDays = CalendarViewModel().previouseDaysInMonth(dateHolder.date)
            
            let startingPrevMonth: Int = {
                if firstDay == 1 {
                    return prevNumberOfDays-6
                } else {
                    return prevNumberOfDays-7+firstDay
                }
            }()
            
            let numberOfDays = CalendarViewModel().daysInMonth(dateHolder.date)
            let array = setDays(Array(startingPrevMonth...prevNumberOfDays),.previous) + setDays(Array(1...numberOfDays), .current) + setDays(Array(1...14), .next)
            
            ForEach(0..<42) { day in
                Button(action: {
                    dateHolder.date = CalendarViewModel().changeDay(array[day], dateHolder.date)
                    withAnimation(.easeInOut(duration: 1)) {
                        scrollValue.scrollTo((CalendarViewModel().month(dateHolder.date)))
                    }
                }) {
                    Circle().overlay(
                        Text("\(array[day].value)").bold()
                            .foregroundColor(colourToday(array[day]))
                    )
                    .foregroundColor(.pink.opacity(isToday(array[day]) ? 0.5 : 0))
                }
            }
        }
    }
    func colourToday(_ day: Day) -> Color {
        
        if isToday(day) {
            return .white
        } else if day.monthState == .current {
            return .black
        } else {
            return .gray
        }
    }
    
    func isToday(_ day: Day) -> Bool {
        return day.monthState == .current && CalendarViewModel().day(dateHolder.date) == day.value
        
    }
}

struct CalendarView_Previews: PreviewProvider {
    @StateObject static var dateHolder = DateHolder()
    static var previews: some View {
        CalendarView()
            .environmentObject(dateHolder)
    }
}
