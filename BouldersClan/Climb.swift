//
//  Climb.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 11/07/2022.
//

import Foundation

struct Climb: Identifiable, Codable {
    var id = UUID()
    let grade: Int
    let isSent: Bool
    let attempts: Int
    let selectedColourIndex: Int
    var colours = ["White", "Green", "Blue", "Black", "Pink", "Red", "Purple", "Yellow", "Orange"]
    let routeColour: String
    let date: Date
    var isKeyProject: Bool
    
    var formattedGrade: String {
        return "V\(grade)"
    }
    
    func formattedAttempts(short: Bool) -> String {
        short ? "\(attempts)" : "\(attempts) attempts"
    }
    
    var climbDate: String {
        date.formatted(date: .abbreviated, time: .omitted)
    }
    
    var climbTime: String {
        date.formatted(date: .omitted, time: .shortened)
    }
}
