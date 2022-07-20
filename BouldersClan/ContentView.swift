//
//  ContentView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 11/07/2022.
//

import SwiftUI

func routeColour(_ gradeColour: String) -> Color {
    switch gradeColour {
        case "Green":
            return .green
        case "White":
        return .gray.opacity(0.2)
        case "Blue":
            return .blue
        case "Black":
            return .black
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
        "date": "%K > %@",
        "todayDate": "date >= %@ && date <= %@"
    ]
    
    @State private var todaysDate = Calendar.current.startOfDay(for: Date.now)
    @State private var tomorrowsDate = Calendar.current.startOfDay(for: Date.now + 86400)
    
    @State private var filterValue = false
        
    @State private var isShowingGridView = true
    let twelveHoursAgo = Date().addingTimeInterval(-86400)

    
    var body: some View {
        NavigationView {
            Section {
                VStack () {
                    if isShowingGridView {
                        VStack (alignment: .leading) {
                            Text("Key projects")
                                .font(.title)
                            
                            FilteredClimbsView(format: filterFormats["bool"]!, filterKey: "isKeyProject", filterValue: true) { (climb: Climb) in
                                // @todo: Convert this to a view of its own or struct
                                NavigationLink(destination: ClimbView(climb: climb)) {
                                    VStack(alignment: .center) {
                                        Text(climb.formattedGrade)
                                            .font(.title2)
                                            .padding()
                                            .foregroundColor(.black)
                                            .background(PolygonShape(sides: 6).stroke(routeColour(climb.routeColour!), lineWidth: 2))
            
                                        Text(climb.formattedAttempts(short: true))
                                            .padding(-1)
                                            .font(.headline)
                                            .foregroundColor(.black)
            
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    if isShowingGridView {
                        VStack(alignment: .leading) {
                            Text("Recent climbs")
                                .font(.title)
                            
                            ClimbGridView(climbs: climbs)
                        }
                        .padding(.horizontal)
                    } else {
                        ClimbRowView(climbs: climbs)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink(destination: CalendarView(calendar: Calendar(identifier: .gregorian))) {
                    Label("View Calendar view", systemImage: "calendar")
                }
            }
        }


        Section {
            // Filter Proof of concept to be updated with filter tab later...
            Button("Update filter") {
                filterValue.toggle()
            }
            AddClimbView(isShowingGridView: $isShowingGridView)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
