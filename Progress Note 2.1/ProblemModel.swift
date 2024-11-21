//
//  ProblemModel.swift
//  Progress Note 2.1
//
//  Created by Purin Prateepmanowong on 11/12/24.
//

import Foundation

// Define the Problem struct
struct Problem: Identifiable, Hashable {
    let id = UUID() // Unique identifier
    var description: String // Description of the problem
    var clinicalStatus: ClinicalStatus // Clinical status of the problem
}

// Define the ClinicalStatus enum
enum ClinicalStatus: String, CaseIterable {
    case improved = "Improved"
    case stable = "Stable"
    case decline = "Declined"
}
