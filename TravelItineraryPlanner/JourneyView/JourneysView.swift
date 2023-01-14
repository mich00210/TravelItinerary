//
//  JourneysView.swift
//  TravelItineraryPlanner
//
//  Created by Michelle’s Air on 15/12/2022.
//

import SwiftUI

extension View {
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}

struct JourneysView: View {
    @State var showDailyView: Bool = false
    
    var body: some View {
        VStack {
            HStack{
                Button {
                    showDailyView = false
                } label: {
                    Image(systemName: "chevron.left" )
                        .bold()
                }
                .foregroundColor(titleColor)
                .padding()
                .hidden(!showDailyView)
                
                Spacer()
            }
            
            
            if(!showDailyView){
                MainView(showDailyView: $showDailyView)
            } else {
                DailyView(showDailyView: $showDailyView)
            }
        }
    }
}

struct JourneysView_Previews: PreviewProvider {
    static var previews: some View {
        JourneysView()
    }
}
