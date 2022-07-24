//
//  BottomNavbarView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 23/07/2022.
//

import SwiftUI

struct BottomNavbarView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var addClimbIsShowing: Bool
    @Binding var isShowingHomeView: Bool
    @Binding var isShowingCalendar: Bool
    @Binding var isShowingFilterView: Bool
    
    struct navButton: View {
        let title: String
        let action: () -> Void
        let icon: String
        let isSelected: Bool
        let colorScheme: ColorScheme

        func btnColour() -> Color {
            if isSelected && colorScheme == .dark {
                return .white
            }
            
            if !isSelected && colorScheme == .dark || !isSelected && colorScheme == .light {
                return .gray
            }
            
            if isSelected && colorScheme == .light {
                return .black
            }
            
            return .white
        }
        var body: some View {
            Button {
                action()
            } label: {
                VStack {
                    Image(systemName: icon)
                    Text(title)
                        .font(.caption)
                }
            }
            .foregroundColor(btnColour())
            .labelStyle(.iconOnly)
            .font(.largeTitle)
            .padding([.horizontal, .top], 10)
        }
    }
    
    var body: some View {
        HStack {
            navButton(title: "Home", action: showHome, icon: "house", isSelected: isShowingHomeView, colorScheme: colorScheme)
            Spacer()
            navButton(title: "Filtered Climbs", action: showFilteredClimbs, icon: "magnifyingglass", isSelected: isShowingFilterView, colorScheme: colorScheme)
            Spacer()
            navButton(title: "Calendar", action: showCalendarView, icon: "calendar", isSelected: isShowingCalendar, colorScheme: colorScheme)
            Spacer()
            navButton(title: addClimbIsShowing ? "Hide panel" : "Add climb", action: toggleAddClimb, icon: addClimbIsShowing ? "arrow.down" : "plus", isSelected: addClimbIsShowing, colorScheme: colorScheme)
        }
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
    
    func toggleAddClimb() {
        withAnimation {
            addClimbIsShowing.toggle()
        }
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
