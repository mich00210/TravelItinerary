//
//  CardView.swift
//  TravelItineraryPlanner
//
//  Created by Michelle’s Air on 15/1/2023.
//

import SwiftUI
enum DragState {
    case unknown
    case good
    case bad
}
struct CardView: View {
    @State var dragAmount = CGSize.zero
    @State var dragState: DragState = .unknown
    let title: String
    let description: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 8)
                .shadow(color: dragColor, radius: dragAmount == .zero ? 0 : 8)
                .padding()
            VStack(alignment: .leading) {
                Text(title)
                    .bold()
                    .font(.title3)
                Text(description)
                    .foregroundColor(.gray)
            }
           
        }
        .offset(dragAmount)
        .zIndex(dragAmount == .zero ? 0 : 1)
        .gesture(
            DragGesture()
                .onChanged { value in
                    print(value)
                    dragAmount = value.translation
                    
                }.onEnded{ value in
                    withAnimation(.spring()) {
                        dragAmount = .zero
                    }
                }
        )
    }
    
    var dragColor: Color {
        switch dragState {
        case .unknown:
               return .black
        case .good:
            return  .green
        case .bad:
            return   .red
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CardView(title: "test", description: "description")
            CardView(title: "test", description: "description")
            CardView(title: "test", description: "description")
        }
    }
}
