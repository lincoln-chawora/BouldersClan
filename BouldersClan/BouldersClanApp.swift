//
//  BouldersClanApp.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 11/07/2022.
//

import SwiftUI

@main
struct BouldersClanApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            // .managedObjectContext - this is the live object of the data in memory.
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
