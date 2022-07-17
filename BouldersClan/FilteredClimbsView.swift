//
//  FilteredClimbView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 14/07/2022.
//

import SwiftUI

struct FilteredClimbsView: View {
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.date)
    ]) var climbs: FetchedResults<Climb>
    
    enum FilterType {
        case none, isSent, notSent, isKeyProject, today
    }
    
    let filter: FilterType
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var filteredProjects: [Climb] {
        switch filter {
            case .none:
                return climbs.reversed()
            case .isSent:
                return climbs.filter { $0.isSent }
            case .notSent:
                return climbs.filter { !$0.isSent }
            case .isKeyProject:
                return climbs.filter { $0.isKeyProject }
            case .today:
                return climbs.filter { Calendar.current.isDateInToday($0.date!) }
        }
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(filteredProjects) { climb in
                    NavigationLink(destination: ClimbView(climb: climb)) {
                        VStack(alignment: .center) {
                            Text(climb.formattedGrade)
                                .font(.title2)
                                .padding()
                                .foregroundColor(.black)
                                .background(PolygonShape(sides: 6).stroke(routeColour(climb.routeColour!), lineWidth: 2))
                            
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

struct FilteredClimbsView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredClimbsView(filter: .none)
    }
}
