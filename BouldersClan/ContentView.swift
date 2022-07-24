//
//  ContentView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 11/07/2022.
//

import SwiftUI

func routeColour(_ gradeColour: String, _ colourScheme: ColorScheme = .dark) -> Color {
    switch gradeColour {
        case "Green":
            return .green
        case "White":
        return colourScheme == .dark ? .white : .gray.opacity(0.2)
        case "Blue":
            return .blue
        case "Black":
        return colourScheme == .dark ? .gray.opacity(0.5) : .black
        case "Pink":
            return .pink
        case "Red":
            return .red
        case "Purple":
            return .purple
        case "Yellow":
            return .yellow
        case "Orange":
            return .orange
        default:
            return .clear
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \Climb.date, ascending: false)
    ]) var climbs: FetchedResults<Climb>
    
    private let filterFormats = [
        "bool": "%K == %i",
        "string": "%K == %@",
        "allPast": "date < %@",
        "todayDate": "date >= %@ && date <= %@"
    ]
    
    @State private var todaysDate = Calendar.current.startOfDay(for: Date.now)
    @State private var tomorrowsDate = Calendar.current.startOfDay(for: Date.now + 86400)
    
    @State private var filterValue = false
        
    @State private var isShowingHomeView = true
    @State private var isShowingCalendar = false
    @State private var isShowingFilterView = false
    @State private var addClimbIsShowing = true
    
    @State private var numberOfKeyProjects = 0
    @State private var numberOfResults = 0
    
    var body: some View {
        NavigationView {
            Section {
                VStack () {
                    if isShowingHomeView  {
                        VStack (alignment: .leading) {
                            Text("Key projects: \(numberOfKeyProjects)")
                                .font(.title)
                            
                            ScrollView(.horizontal) {
                                HStack(spacing: 20) {
                                    FilteredClimbsView(format: filterFormats["bool"]!, keyOrValue: "isKeyProject", filterValue: true, numberOfResults: $numberOfKeyProjects) { (climb: Climb) in
                                        ClimbGridTeaserView(climb: climb, simple: true)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)

                        VStack(alignment: .leading) {
                            Text("Recent climbs")
                                .font(.title)
                            
                            ClimbGridView(climbs: climbs)
                        }
                        .padding(.horizontal)
                    }
                    
                    if isShowingCalendar {
                        CalendarView(calendar: Calendar(identifier: .gregorian))
                    }
                    
                    if isShowingFilterView {
                        List {
                            ForEach(climbs) { climb in
                                NavigationLink(destination: ClimbView(climb: climb)) {
                                    ClimbRowView(climb: climb)
                                }
                            }
                        }
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                EditButton()
                            }
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink(destination: SettingsView()) {
                    Label("View settings", systemImage: "person.circle")
                }
            }
        }

        Section {
            if addClimbIsShowing {
                AddClimbView(isShowingGridView: $isShowingHomeView)
                    .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
                        .onEnded { value in
                            switch(value.translation.width, value.translation.height) {
                                case (-100...100, 0...):  withAnimation { addClimbIsShowing = false }
                                default:  print("no clue")
                            }
                        })
            }
            BottomNavbarView(
                addClimbIsShowing: $addClimbIsShowing,
                isShowingHomeView: $isShowingHomeView,
                isShowingCalendar: $isShowingCalendar,
                isShowingFilterView: $isShowingFilterView
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
