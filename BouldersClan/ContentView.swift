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
    // Filter by isSent or Not -:>{ predicate: NSPredicate(format: "isSent == %i", 0) }
    @FetchRequest(sortDescriptors: []) var climbs: FetchedResults<Climb>
    
    @State private var isShowingGridView = true
    
    var body: some View {
        NavigationView {
            Section {
                VStack () {
                    if isShowingGridView {
                        VStack (alignment: .leading) {
                            Text("Key projects")
                                .font(.title)
                            
                            FilteredClimbsView(filter: .isKeyProject)
                        }
                        .padding(.horizontal)
                    }
                    
                    if isShowingGridView {
                        VStack(alignment: .leading) {
                            Text("Recent climbs")
                                .font(.title)
                            
                            ClimbGridView(climbs: _climbs)
                        }
                        .padding(.horizontal)
                    } else {
                        ClimbRowView(climbs: _climbs)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        
        Section {
            AddClimbView(isShowingGridView: $isShowingGridView)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
