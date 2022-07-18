//
//  ClimbGridView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 11/07/2022.
//

import SwiftUI
import CoreData

struct ClimbGridView: View {
    @Environment(\.managedObjectContext) var moc
    let climbs: FetchedResults<Climb>
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(climbs) { climb in
                    NavigationLink(destination: ClimbView(climb: climb)) {
                        VStack(alignment: .center) {
                            Text(climb.formattedGrade)
                                .font(.title2)
                                .padding(12)
                                .foregroundColor(.black)
                                .background(PolygonShape(sides: 6).stroke(routeColour(climb.routeColour!), lineWidth: 2))
                            
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
    }
}
