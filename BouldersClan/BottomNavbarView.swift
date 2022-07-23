//
//  BottomNavbarView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 23/07/2022.
//

import SwiftUI

struct BottomNavbarView: View {
    @Binding var addClimbIsShowing: Bool
    @Binding var isShowingHomeView: Bool
    @Binding var isShowingCalendar: Bool
    @Binding var isShowingFilterView: Bool
    var body: some View {
        HStack {
            Button {
                isShowingHomeView = true
                isShowingCalendar = false
                isShowingFilterView = false
            } label: {
                Label("Home screen", systemImage: "house")
            }
            Spacer()
            Button {
                isShowingFilterView = true
                isShowingCalendar = false
                isShowingHomeView = false
            } label: {
                Label("Filtered climbs screen", systemImage: "magnifyingglass")
            }
            Spacer()
            Button {
                isShowingCalendar = true
                isShowingFilterView = false
                isShowingHomeView = false
            } label: {
                Label("Calendar view", systemImage: "calendar")
            }
            Spacer()
            Button {
                withAnimation {
                    addClimbIsShowing.toggle()
                }
            } label: {
                Label("Show or hide add climb panel", systemImage: addClimbIsShowing ? "minus" : "plus")
            }
        }
        .labelStyle(.iconOnly)
        .font(.largeTitle)
        .foregroundColor(.black)
        .padding([.horizontal, .top], 10)
        .background(Color.gray.opacity(0.1))
        .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
            .onEnded { value in
                switch(value.translation.width, value.translation.height) {
                    case (-100...100, ...0):  withAnimation { addClimbIsShowing = true }
                    case (-100...100, 0...):  withAnimation { addClimbIsShowing = false }
                    default:  print("no clue")
                }
            }
        )
    }
}
