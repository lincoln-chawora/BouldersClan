//
//  ClimbView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 11/07/2022.
//

import SwiftUI

struct ClimbView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var climb: Climb
    @State private var climbNote = ""
    
    var body: some View {
        ScrollView {
            HStack(alignment: .top) {
                VStack {
                    Text(climb.formattedGrade)
                        .padding(20)
                        .font(.largeTitle)
                        .foregroundColor(routeColour(climb.routeColour!))
                        .background(PolygonShape(sides: 6).stroke(routeColour(climb.routeColour!), lineWidth: 3))
                }
                    
                Spacer()
                
                VStack(alignment: .leading) {
                    // @todo: Fix toggling issue
                    Button {
                        climb.isKeyProject.toggle()
                        climb.isKeyProject = climb.isKeyProject
                        if moc.hasChanges {
                            try? moc.save()
                        }
                    } label: {
                        Label("Project", systemImage: climb.isKeyProject ? "star.fill" : "star")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    
                    Text(climb.climbDate)
                    Text(climb.climbTime)
                }
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding(.vertical, 3)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Attemps")
                    if climb.attempts == 1 && climb.isSent {
                        Label("Flashed", systemImage: "bolt")
                            .font(.title)
                            .foregroundColor(.yellow)
                    } else {
                        Text(climb.formattedAttempts(short: false))
                            .font(.title)
                    }
                    
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Status")
                    Text(climb.isSent ? "Sent" : "No send")
                        .font(.title)
                        .foregroundColor(climb.isSent ? .green : .red)
                }
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding(.vertical, 3)
            
            VStack (alignment: .leading) {
                TextField("Notes", text: $climbNote)
                    .foregroundColor(.secondary)
                
                // @todo: Fix data persistance issue here
                Button("Save note") {
                    climb.notes = climbNote
                    if moc.hasChanges {
                        try? moc.save()
                    }
                }
                .padding(.top)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
                    .padding(.vertical, 3)
                
                Text("Route")
                Image("climbroute")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
            }
        }
        .padding()
    }
}
