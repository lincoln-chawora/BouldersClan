//
//  Climbs.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 11/07/2022.
//

import Foundation

class Climbs: ObservableObject {
    @Published var items = [Climb]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        // Read data from the userdefaults targeting the key "Climbs".
        if let savedClimbs = UserDefaults.standard.data(forKey: "Items") {
            // Decode data as an array of expense items (.self means the actual array type of Climb).
            if let decodedClimbs = try? JSONDecoder().decode([Climb].self, from: savedClimbs) {
                items = decodedClimbs
                return
            }
        }
        items = []
    }
    
}
