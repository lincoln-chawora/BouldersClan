//
//  Climb+CoreDataProperties.swift
//  BouldersClan
//
//  Created by Lincoln Chawora on 16/07/2022.
//
//

import Foundation
import CoreData


extension Climb {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Climb> {
        return NSFetchRequest<Climb>(entityName: "Climb")
    }

    @NSManaged public var attempts: Int16
    @NSManaged public var date: Date?
    @NSManaged public var grade: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var isKeyProject: Bool
    @NSManaged public var isSent: Bool
    @NSManaged public var routeColour: String?
    @NSManaged public var selectedColourIndex: Int16
    @NSManaged public var routeImage: Data?
    @NSManaged public var notes: String?

    public var formattedGrade: String {
        "V\(grade)"
    }
    
    public var wrappedDate: Date {
        date ?? Date.now
    }
    
    var climbDate: String {
        (date?.formatted(date: .numeric, time: .omitted))!
    }
    
    var climbTime: String {
        (date?.formatted(date: .omitted, time: .shortened))!
    }
    
    func formattedAttempts(short: Bool) -> String {
        short ? "\(attempts)" : attempts == 1 ? "\(attempts) attempt" : "\(attempts) attempts"
    }

}

extension Climb : Identifiable {

}
