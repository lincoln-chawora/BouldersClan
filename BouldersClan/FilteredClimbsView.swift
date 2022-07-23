//
//  FilteredClimbView.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 14/07/2022.
//

import CoreData
import SwiftUI

struct FilteredClimbsView<T: NSManagedObject, Content: View>: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest var fetchRequest: FetchedResults<T>
    
    @Binding var numberOfResults: Int
    
    let content: (T) -> Content
    
    var body: some View {
        ForEach(fetchRequest, id: \.self) { climb in
            self.content(climb)
        }
        .onDelete(perform: removeItems)
        .onReceive(fetchRequest.publisher.count()) { _ in
            numberOfResults = fetchRequest.count
        }
    }
    
    // Removes items from list display view.
    func removeItems(at offsets: IndexSet) {
        for index in offsets {
            let climb = fetchRequest[index]
            moc.delete(climb)
        }

        do {
            if moc.hasChanges {
              try moc.save()
            }
        } catch {
            print("Failed to remove climb from row.")
        }
    }
    
    init(format: String, keyOrValue: Any, filterValue: Any, isDateView: Bool = false, numberOfResults: Binding<Int>, @ViewBuilder content: @escaping (T) -> Content) {
        if isDateView {
            _fetchRequest = FetchRequest<T>(sortDescriptors: [
                NSSortDescriptor(keyPath: \Climb.date, ascending: false)
            ], predicate: NSPredicate(
                format: format,
                keyOrValue as! NSDate,
                filterValue as! NSDate))
        } else {
            _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(
                format: format,
                keyOrValue as! CVarArg,
                filterValue as! CVarArg))
        }
        self.content = content
        self._numberOfResults = numberOfResults
    }
}
