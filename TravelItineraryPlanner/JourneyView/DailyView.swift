//
//  DailyView.swift
//  TravelItineraryPlanner
//
//  Created by Michelle’s Air on 9/12/2022.
//

import SwiftUI

struct DailyView: View {
    @EnvironmentObject var dateHolder: DateHolder
    let showDailyView: Binding<Bool>
    @State var showDatePicker: Bool = false
    
    var events: [Event] = [.init(title: "Airport", description: "Description", time: .now), .init(title: "Hotel", description: "description", color: .blue, time: .now)]
    
    struct Event {
        let id = UUID()
        var title: String
        var description: String
        var color: Color = .pink.opacity(0.5)
        var time: Date
        
    }
    var body: some View {
        VStack(alignment: .leading) {
            Text(CalendarViewModel().dayMonth(dateHolder.date))
                .foregroundColor(titleColor)
                .font(.title).bold()
            
            // show week
            // get array of days
            let today = CalendarViewModel().dayMonth(dateHolder.date)
            
            
            
            ScrollView() {
                VStack(alignment: .leading, spacing: -15) {
                    ForEach(events, id: \.id) { event in
                        EventView(startTime: event.time, title: event.title, description: event.description, color: event.color)
                    }
                    
//                    EventView(startTime: Date(), title: "Hotel", description: "description", color: .cyan)
                }
                
            }
            .padding()
            
        }
    }
}

func EventView(startTime: Date, title: String, description: String, color: Color) -> some View {
    HStack(alignment: .top) {
        Text(startTime.formatted(.dateTime.hour().minute()))
            .bold()
            .foregroundColor(titleColor)
            .padding(.horizontal, 10)
            .padding(.vertical, 3)
            .background(
                Rectangle()
                    .fill(secondaryColor)
                    .cornerRadius(15))
        VStack(spacing: -10) {
            Circle()
                .fill(.red)
                .frame(width: 15)
                .zIndex(10)
            Capsule()
                .fill(color)
                .frame(width: 15, height: 150)
        }
        
        VStack(alignment: .leading) {
            Text(title)
                .bold()
                .font(.title3)
            Text(description)
                .foregroundColor(.gray)
        }
        Spacer()
    }
}

struct DailyView_Previews: PreviewProvider {
    @StateObject static var dateHolder = DateHolder()
    static var previews: some View {
        DailyView(showDailyView: .constant(true))
            .environmentObject(dateHolder)
            .padding()
    }
}
