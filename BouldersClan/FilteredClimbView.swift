//
//  FilteredClimbView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 14/07/2022.
//

import SwiftUI

struct FilteredClimbView: View {
    @StateObject var climbs = Climbs()
    
    enum FilterType {
        case none, isSent, notSent, isKeyProject
    }
    
    let filter: FilterType
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var keyProjects: [Climb] {
        switch filter {
            case .none:
                return climbs.items
            case .isSent:
                return climbs.items.filter { $0.isSent }
            case .notSent:
                return climbs.items.filter { !$0.isSent }
            case .isKeyProject:
                return climbs.items.filter { $0.isKeyProject }
        }
    }
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(keyProjects) { climb in
                NavigationLink(destination: ClimbView(climb: climb)) {
                    VStack(alignment: .center) {
                        Text("V\(climb.grade)")
                            .font(.title2)
                            .padding()
                            .foregroundColor(.black)
                            .background(PolygonShape(sides: 6).stroke(routeColour(climb.routeColour), lineWidth: 2))
                        
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

struct FilteredClimbView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredClimbView(filter: .none)
    }
}
