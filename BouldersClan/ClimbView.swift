//
//  ClimbView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 11/07/2022.
//

import SwiftUI

struct ClimbView: View {
    var climb: Climb
    @State private var climbNote = "Enter your bio"
    
    var body: some View {
        Form {
            VStack {
                HStack(alignment: .top) {
                    VStack {
                        Text(climb.formattedGrade)
                            .padding(20)
                            .font(.largeTitle)
                            .foregroundColor(routeColour(climb.routeColour))
                            .background(PolygonShape(sides: 6).stroke(routeColour(climb.routeColour), lineWidth: 3))
                    }
                        
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Button {
                            // @todo:: Add functionality to update isKeyProject to true
                            print("Add climb to key projects")
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
                        Text("Completion")
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
                    Text("Notes")
                    TextEditor(text: $climbNote)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
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
            .padding(.top, 20)
        }
    }
}

struct ClimbView_Previews: PreviewProvider {
    static var climbs = Climbs()
    static var previews: some View {
        ClimbView(climb: climbs.items[0])
    }
}
