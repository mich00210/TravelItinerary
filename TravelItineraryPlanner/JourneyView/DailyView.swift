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
    
    @State var events: [Event] = [.init(title: "Airport", description: "Description", time: .now), .init(title: "Hotel", description: "description", color: .blue, time: .now)]
    
    struct Event {
        let id = UUID()
        var title: String
        var description: String
        var color: Color = .pink.opacity(0.5)
        var time: Date
        
    }
    
    func addEvent() {
        events.append(.init(title: "default", description: "desc", time: .now))
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack {
                Text(CalendarViewModel().dayMonth(dateHolder.date))
                    .bold()
                    .foregroundColor(.black.opacity(0.6))
                    .font(.title)
                Text("Japan 1")
                    .bold()
                    .foregroundColor(titleColor)
                    .font(.largeTitle)
            }
            .padding(.horizontal, 40)
            
            // show week
            // get array of days
            let today = CalendarViewModel().dayMonth(dateHolder.date)
            
            
            
            ScrollView() {
                VStack(alignment: .leading, spacing: -15) {
                    
                    // TODO: Refactor
                    // Have the timeline on the outside because zIndex only works within a container
                    ForEach(events, id: \.id) { event in
                        EventView(startTime: event.time, title: event.title, description: event.description, color: event.color)
                            
                    }
                    
                }
                
                
            }
            .padding()
            Spacer()
            HStack {
                Spacer()
                Button(action: {addEvent()} ) {
                    Circle()
                        .frame(width: 80)
                        .foregroundColor(titleColor)
                        .padding()
                        .overlay {
                            Image(systemName: "pencil" )
                                .font(.title)
                                .foregroundColor(.white)
                                .bold()
                        }
                }
                
            }
            
        }
    }
    
}

struct EventView:  View {
    
    let startTime: Date
    let title: String
    let description: String
    let color: Color
    
    var body: some View {
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
                Capsule()
                    .fill(color)
                    .frame(width: 15, height: 150)
            }
            
            CardView(title: title, description: description)
            
            Spacer()
        }
        
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
