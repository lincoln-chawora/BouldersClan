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
                showHome()
            } label: {
                VStack {
                    Image(systemName: "house")
                    Text("Home")
                        .font(.caption)
                }
            }
            Spacer()
            Button {
                showFilteredClimbs()
            } label: {
                VStack {
                    Image(systemName: "magnifyingglass")
                    Text("Filtered Climbs")
                        .font(.caption)
                }
            }
            Spacer()
            Button {
                showCalendarView()
            } label: {
                VStack {
                    Image(systemName: "calendar")
                    Text("Calendar")
                        .font(.caption)
                }
            }
            Spacer()
            Button {
                withAnimation {
                    addClimbIsShowing.toggle()
                }
            } label: {
                VStack {
                    Image(systemName: addClimbIsShowing ? "arrow.down" : "plus")
                    Text(addClimbIsShowing ? "Hide panel" : "Add climb")
                        .font(.caption)
                }
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
    
    func showHome() {
        isShowingHomeView = true
        isShowingCalendar = false
        isShowingFilterView = false
    }
    
    func showFilteredClimbs() {
        isShowingFilterView = true
        isShowingCalendar = false
        isShowingHomeView = false
    }
    
    func showCalendarView() {
        isShowingCalendar = true
        isShowingFilterView = false
        isShowingHomeView = false
    }
}
