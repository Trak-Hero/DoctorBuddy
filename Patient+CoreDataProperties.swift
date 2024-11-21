//
//  Patient+CoreDataProperties.swift
//  Progress Note 2.1
//
//  Created by Purin Prateepmanowong on 11/14/24.
//
//

import Foundation
import CoreData


extension Patient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Patient> {
        return NSFetchRequest<Patient>(entityName: "Patient")
    }

    @NSManaged public var age: Int16
    @NSManaged public var contactInfo: String?
    @NSManaged public var dateOfBirth: Date?
    @NSManaged public var gender: String?
    @NSManaged public var hospitalNumber: String?
    @NSManaged public var id: UUID?
    @NSManaged public var medicalHistory: String?
    @NSManaged public var name: String?
    @NSManaged public var progressNotes: NSSet?

}

// MARK: Generated accessors for progressNotes
extension Patient {

    @objc(addProgressNotesObject:)
    @NSManaged public func addToProgressNotes(_ value: ProgressNote)

    @objc(removeProgressNotesObject:)
    @NSManaged public func removeFromProgressNotes(_ value: ProgressNote)

    @objc(addProgressNotes:)
    @NSManaged public func addToProgressNotes(_ values: NSSet)

    @objc(removeProgressNotes:)
    @NSManaged public func removeFromProgressNotes(_ values: NSSet)

}

extension Patient : Identifiable {

}
