//
//  DataController.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 16/07/2022.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    // NSPersistent is the actual data being loaded and saved onto the device.
    let container = NSPersistentContainer(name: "BouldersClan")
    
    init() {
        container.loadPersistentStores { desciption, error in
            if let error = error {
                print("Core Date failed to load: \(error.localizedDescription)")
            }
        }
    }
}

