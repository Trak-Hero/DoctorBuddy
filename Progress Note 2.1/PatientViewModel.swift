//
//  PatientViewModel.swift
//  Progress Note 2.1
//
//  Created by Purin Prateepmanowong on 10/29/24.
//

import SwiftUI
import CoreData

class PatientViewModel: ObservableObject {
    // Properties to hold and observe data
    @Published var progressNotes: [ProgressNote] = []
    @Published var patient: Patient

    init(patient: Patient) {
        self.patient = patient
        self.fetchProgressNotes() // Load existing notes on initialization
    }

    // Function to add a new progress note
    func addProgressNoteForPatient(subjective: String, systolicBP: Int, diastolicBP: Int, heartRate: Int, respiratoryRate: Int, temperature: Double, plan: String) {
        DataManager.shared.saveProgressNote(for: patient,
                                            subjective: subjective,
                                            systolicBP: systolicBP,
                                            diastolicBP: diastolicBP,
                                            heartRate: heartRate,
                                            respiratoryRate: respiratoryRate,
                                            temperature: temperature,
                                            plan: plan)
        fetchProgressNotes() // Reload progress notes to update the view
    }

    // Function to fetch all progress notes for this patient
    func fetchProgressNotes() {
        if let notes = patient.progressNotes?.allObjects as? [ProgressNote] {
            self.progressNotes = notes.sorted { $0.date ?? Date() > $1.date ?? Date() } // Sort by date
        }
    }
}
