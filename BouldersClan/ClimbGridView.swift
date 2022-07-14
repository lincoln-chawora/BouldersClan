//
//  ClimbGridView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 11/07/2022.
//

import SwiftUI

struct ClimbGridView: View {
    let climbs: Climbs
        
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
                ForEach(climbs.items) { climb in
                    NavigationLink(destination: ClimbView(climb: climb)) {
                        VStack(alignment: .center) {
                            Text("V\(climb.grade)")
                                .font(.title2)
                                .padding()
                                .foregroundColor(.black)
                                .background(PolygonShape(sides: 6).stroke(routeColour(climb.routeColour), lineWidth: 2))
                            
                            if climb.attempts == 1 && climb.isSent {
                                Label("\(climb.attempts)", systemImage: "bolt.fill")
                                    .labelStyle(.iconOnly)
                                    .foregroundColor(.black)
                            } else {
                                if !climb.isSent {
                                    Text("X")
                                        .bold()
                                        .foregroundColor(.red)
                                } else {
                                    Text("\(climb.attempts)")
                                        .padding(-1)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                }
                            }
                            
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct ClimbGridView_Previews: PreviewProvider {
    static var climbs = Climbs()
    static var previews: some View {
        ClimbGridView(climbs: climbs)
    }
}
