//
//  ClimbRowView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 11/07/2022.
//

import SwiftUI

struct ClimbRowView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.date)
    ]) var climbs: FetchedResults<Climb>
    
    var body: some View {
        // @todo:: Make this Lazy.
        List {
            ForEach(climbs) { climb in
                NavigationLink(destination: ClimbView(climb: climb)) {
                    HStack {
                        VStack {
                            Rectangle()
                                .fill(routeColour(climb.routeColour!))
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
        for index in offsets {
            let climb = climbs[index]
            moc.delete(climb)
        }

        do {
            if moc.hasChanges {
              try moc.save()
            }
        } catch {
            print("Lol something went wrong")
        }
    }
}
