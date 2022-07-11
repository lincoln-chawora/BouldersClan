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
                        Text("V\(climb.grade)")
                            .padding()
                            .foregroundColor(.white)
                            .background(colorToShow(climb.routeColour))
                            .clipShape(PolygonShape(sides: 6).rotation(Angle.degrees(90)))
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
