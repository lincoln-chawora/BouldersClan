//
//  ClimbRowView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 11/07/2022.
//

import SwiftUI

struct ClimbRowView: View {
    @ObservedObject var climbs: Climbs
    
    var body: some View {
        // @todo:: Make this Lazy.
        List {
            ForEach(climbs.items) { climb in
                NavigationLink(destination: ClimbView(climb: climb)) {
                    HStack {
                        VStack {
                            Rectangle()
                                .fill(routeColour(climb.routeColour))
                                .frame(width: 5, height: 50)
                        }
                        VStack {
                            HStack {
                                Text(climb.climbDate)
                                Spacer()
                                Text(climb.climbTime)
                            }
                        
                            HStack {
                                Text(climb.formattedGrade)
                                Spacer()
                                Text(climb.attempts == 1 && climb.isSent ? "Flashed" : climb.formattedAttempts(short: false))
                                    .frame(width: 100, alignment: .leading)
                                Spacer()
                                Text(climb.isSent ? "Sent" : "No send")
                                    .frame(width: 70, alignment: .trailing)
                            }
                        }
                        VStack {
                            Rectangle()
                                .fill(climb.isSent ? .green : .red)
                                .frame(width: 5, height: 50)
                        }
                    }
                }
            }
            .onDelete(perform: removeItems)
        }
    }
    
    // Removes items from list display view.
    func removeItems(at offsets: IndexSet) {
        climbs.items.remove(atOffsets: offsets)
    }
}

struct ClimbRowView_Previews: PreviewProvider {
    static var climbs = Climbs()
    static var previews: some View {
        ClimbRowView(climbs: climbs)
    }
}
