//
//  MainJourneyView.swift
//  TravelItineraryPlanner
//
//  Created by Michelle’s Air on 16/12/2022.
//

import SwiftUI
struct Journey {
    let id = UUID()
    var name: String
    var numberOfActivities: Int
    var color: Color
    
}
struct MainView: View {
    let showDailyView: Binding<Bool>
    
    @State var journeys: [Journey] = [.init(name: "Japan 1", numberOfActivities: 5, color: titleColor),.init(name: "Japan 2", numberOfActivities: 2, color: titleColor), .init(name: "Japan 3", numberOfActivities: 4, color: titleColor)]
    func addJourney() {
        journeys.append(.init(name: "New", numberOfActivities: 0, color: .yellow))
    }
    var body: some View {
        VStack {
            HStack {
                Text("Your journeys")
                    .bold()
                    .foregroundColor(.black.opacity(0.6))
                    .font(.title)
                Spacer()
                Button(action: {addJourney()}) {
                    ZStack {
                        RoundedRectangle(cornerSize: .init(width: 10, height: 10))
                            .frame(width: 80, height: 32)
                            .foregroundColor(secondaryColor)
                        Text("+ Add")
                            .bold()
                            .foregroundColor(titleColor)
                    }
                }
            }
            .padding(.horizontal, 40)
            ScrollView {
                LazyVGrid(columns: [GridItem(.fixed(180)), GridItem(.fixed(180))]) {
                    ForEach(journeys, id: \.id) { journey in
                        Button(action: {showDailyView.wrappedValue = true} ){
                            ZStack {
                                RoundedRectangle(cornerSize: .init(width: 5, height: 5))
                                    .foregroundColor(journey.color)
                                    .frame(width: 150, height: 200)
                                    .padding().overlay(
                                        VStack {
                                            HStack {
                                                Text(journey.name)
                                                    .bold()
                                                    .font(.title)
                                                    .foregroundColor(.white)
                                                Spacer()
                                            }
                                            Spacer()
                                            HStack {
                                                Spacer()
                                                Text("\(journey.numberOfActivities)")
                                                    .bold()
                                                    .foregroundColor(.white.opacity(0.8))
                                                    .font(.system(size: 80))
                                            }
                                        }
                                            .padding(30)
                                    )
                            }
                        }
                    }
                }
            }
        }
    }
}

struct MainJourneyView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(showDailyView: .constant(false))
    }
}
