//
//  TravelItineraryPlannerApp.swift
//  TravelItineraryPlanner
//
//  Created by Michelle’s Air on 9/12/2022.
//

import SwiftUI

@main
struct TravelItineraryPlannerApp: App {
    var body: some Scene {
        WindowGroup {
            let dateHolder = DateHolder()
            ContentView()
                .environmentObject(dateHolder)
            
        }
    }
}
