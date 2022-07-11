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
    let selectedColour: String
    let date: Date
}
