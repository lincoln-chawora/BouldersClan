//
//  ContentView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 11/07/2022.
//

import SwiftUI

func colorToShow(_ gradeColour: String) -> Color {
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

struct PolygonShape: Shape {
    var sides: Int
    
    func path(in rect: CGRect) -> Path {
        let h = Double(min(rect.size.width, rect.size.height)) / 2.0
        let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        var path = Path()
        
        for i in 0..<sides {
            let angle = (Double(i) * (360.0 / Double(sides))) * Double.pi / 180
            
            let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))
            
            if i == 0 {
                path.move(to: pt) // move to first vertex
            } else {
                path.addLine(to: pt) // draw line to next vertex
            }
        }
        
        path.closeSubpath()
        
        return path
    }
}

struct ContentView: View {
    
    @StateObject var climbs = Climbs()
    @State private var isShowingGridView = true
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        NavigationView {
            Section {
                if isShowingGridView {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(climbs.items) { climb in
                                NavigationLink(destination: ClimbView(grade: climb.grade, isSent: climb.isSent, attempts: climb.attempts, date: climb.date, selectedColour: climb.selectedColour)) {
                                    Text("V\(climb.grade)")
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(colorToShow(climb.selectedColour))
                                        .clipShape(PolygonShape(sides: 6).rotation(Angle.degrees(90)))
                                  }
                            }
                        }
                        .padding(.horizontal)
                    }
                } else {
                    List {
                        ForEach(climbs.items) { climb in
                            NavigationLink(destination: ClimbView(grade: climb.grade, isSent: climb.isSent, attempts: climb.attempts, date: climb.date, selectedColour: climb.selectedColour)) {
                                ClimbRowView(grade: climb.grade, isSent: climb.isSent, attempts: climb.attempts, date: climb.date, selectedColour: climb.selectedColour)
                            }
                        }
                        .onDelete(perform: removeItems)
                    }
                }
            }
            .navigationTitle("BouldersClan")
        }
        
        Section {
            AddClimbView(climbs: climbs, isShowingGridView: $isShowingGridView)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        climbs.items.remove(atOffsets: offsets)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
