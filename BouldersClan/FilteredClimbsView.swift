//
//  FilteredClimbView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 14/07/2022.
//

import CoreData
import SwiftUI

struct FilteredClimbsView<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    let content: (T) -> Content
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(fetchRequest, id: \.self) { climb in
                    self.content(climb)
                }
            }
        }
    }
    
    init(format: String, filterKey: Any, filterValue: Any, @ViewBuilder content: @escaping (T) -> Content) {
        // @todo: Find way of dynamically switching NSDate & CVarArg depending on the filterValue type
        // let filterValueType = type(of: filterValue)
        // filterValueType == "Date" ? NSDate : CVarArg
        
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(
            format: format,
            filterKey as! CVarArg,
            filterValue as! CVarArg))
        self.content = content
    }
}
