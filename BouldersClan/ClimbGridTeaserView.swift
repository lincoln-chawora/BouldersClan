//
//  ClimbGridTeaserView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 23/07/2022.
//

import SwiftUI

struct ClimbGridTeaserView: View {
    @ObservedObject var climb: Climb
    var simple: Bool = false
    
    var body: some View {
        NavigationLink(destination: ClimbView(climb: climb)) {
            VStack(alignment: .center) {
                Text(climb.formattedGrade)
                    .font(.title2)
                    .padding(12)
                    .foregroundColor(.black)
                    .background(PolygonShape(sides: 6).stroke(routeColour(climb.routeColour!), lineWidth: 2))
                
                if simple {
                    Text(climb.formattedAttempts(short: true))
                        .padding(-1)
                        .font(.headline)
                        .foregroundColor(climb.isSent ? .green : .red)
                } else {
                    if climb.attempts == 1 && climb.isSent {
                        Label(climb.formattedAttempts(short: true), systemImage: "bolt.fill")
                            .labelStyle(.iconOnly)
                            .foregroundColor(.black)
                    } else {
                        if !climb.isSent {
                            Text("X")
                                .bold()
                                .foregroundColor(.red)
                        } else {
                            Text(climb.formattedAttempts(short: true))
                                .padding(-1)
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
    }
}
