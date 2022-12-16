//
//  MainJourneyView.swift
//  TravelItineraryPlanner
//
//  Created by Michelle’s Air on 16/12/2022.
//

import SwiftUI

struct MainView: View {
    let showDailyView: Binding<Bool>
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.fixed(180)), GridItem(.fixed(180))]) {
                ForEach(1...5, id: \.self) { _ in
                    Button(action: {showDailyView.wrappedValue = true} ){
                        ZStack {
                            RoundedRectangle(cornerSize: .init(width: 5, height: 5))
                                .foregroundColor(titleColor)
                                .frame(width: 150, height: 200)
                                .padding().overlay(
                                    VStack {
                                        HStack {
                                            Text("Japan")
                                                .bold()
                                                .font(.title)
                                                .foregroundColor(.white)
                                            Spacer()
                                        }
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            Text("5")
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

struct MainJourneyView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(showDailyView: .constant(false))
    }
}
