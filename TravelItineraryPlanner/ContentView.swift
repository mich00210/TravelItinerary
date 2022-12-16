//
//  ContentView.swift
//  TravelItineraryPlanner
//
//  Created by Michelle’s Air on 9/12/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View {
        TabView {
            CalendarView()
                .environmentObject(dateHolder)
                .padding(40)
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("Calendar")
                }
            
            
            JourneysView()
            .environmentObject(dateHolder)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Journeys")
            }
            MapView()
                    .tabItem {
                        Image(systemName: "mappin.circle.fill")
                        Text("Map")
                }
            
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static var dateHolder = DateHolder()
    static var previews: some View {
        
        ContentView()
            .environmentObject(dateHolder)
    }
}
