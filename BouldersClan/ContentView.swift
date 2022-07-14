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
    @StateObject var climbs = Climbs()
    @State private var isShowingGridView = true
    let colours = ["White", "Green", "Blue", "Black", "Pink", "Red", "Purple", "Yellow", "Orange"]
    
    var body: some View {
        NavigationView {
            Section {
                VStack () {
                    if isShowingGridView {
                        VStack (alignment: .leading) {
                            Text("Key projects")
                                .padding(.horizontal)
                            
                            FilteredClimbsView(filter: .isKeyProject)
                        }
                    }
                    
                    if isShowingGridView {
                        VStack(alignment: .leading) {
                            Text("Todays session")
                                .font(.title)
                        }
                        ClimbGridView(climbs: climbs)
                    } else {
                        ClimbRowView(climbs: climbs)
                    }
                }
            }
            .navigationTitle("BouldersClan")
        }
        
        Section {
            AddClimbView(climbs: climbs, isShowingGridView: $isShowingGridView)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
