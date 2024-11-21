//
//  ManagedProblem+CoreDataProperties.swift
//  Progress Note 2.1
//
//  Created by Purin Prateepmanowong on 11/14/24.
//
//

import Foundation
import CoreData


extension ManagedProblem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedProblem> {
        return NSFetchRequest<ManagedProblem>(entityName: "ManagedProblem")
    }

    @NSManaged public var clinicalStatus: String?
    @NSManaged public var descriptionP: String?
    @NSManaged public var progressNote: NSSet?

}

// MARK: Generated accessors for progressNote
extension ManagedProblem {

    @objc(addProgressNoteObject:)
    @NSManaged public func addToProgressNote(_ value: ProgressNote)

    @objc(removeProgressNoteObject:)
    @NSManaged public func removeFromProgressNote(_ value: ProgressNote)

    @objc(addProgressNote:)
    @NSManaged public func addToProgressNote(_ values: NSSet)

    @objc(removeProgressNote:)
    @NSManaged public func removeFromProgressNote(_ values: NSSet)

}

extension ManagedProblem : Identifiable {

}
