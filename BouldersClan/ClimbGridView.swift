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
                    ClimbGridTeaserView(climb: climb)
                }
            }
        }
    }
}
