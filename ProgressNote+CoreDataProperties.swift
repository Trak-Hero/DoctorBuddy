//
//  ProgressNote+CoreDataProperties.swift
//  Progress Note 2.1
//
//  Created by Purin Prateepmanowong on 11/14/24.
//
//

import Foundation
import CoreData


extension ProgressNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProgressNote> {
        return NSFetchRequest<ProgressNote>(entityName: "ProgressNote")
    }

    @NSManaged public var abdomen: String?
    @NSManaged public var assessmentProblems: NSObject?
    @NSManaged public var assessmentStatus: NSObject?
    @NSManaged public var attribute: String?
    @NSManaged public var clinicalStatus: String?
    @NSManaged public var cvs: String?
    @NSManaged public var date: Date?
    @NSManaged public var evm: Int16
    @NSManaged public var evmEYE: String?
    @NSManaged public var evmMOTOR: String?
    @NSManaged public var evmVerbal: String?
    @NSManaged public var extremities: String?
    @NSManaged public var generalAppearance: String?
    @NSManaged public var htEar: String?
    @NSManaged public var htEyes: String?
    @NSManaged public var htHead: String?
    @NSManaged public var htNose: String?
    @NSManaged public var htThroat: String?
    @NSManaged public var id: UUID?
    @NSManaged public var investigations: String?
    @NSManaged public var neuroExam: String?
    @NSManaged public var objectiveDiastolicBP: Int16
    @NSManaged public var objectiveHeartRate: Int16
    @NSManaged public var objectiveRespiratoryRate: Int16
    @NSManaged public var objectiveSystolicBP: Int16
    @NSManaged public var objectiveTemperature: Double
    @NSManaged public var pelvicExam: String?
    @NSManaged public var plan: String?
    @NSManaged public var prExam: String?
    @NSManaged public var rs: String?
    @NSManaged public var subjective: String?
    @NSManaged public var problemList: NSSet?
    @NSManaged public var patient: Patient?
    @NSManaged public var probList: ManagedProblem?
    var problemListArray: [ManagedProblem] {
        (problemList?.allObjects as? [ManagedProblem]) ?? []
    }

}

extension ProgressNote : Identifiable {

}
