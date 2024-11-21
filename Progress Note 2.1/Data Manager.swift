//
//  DataManager.swift
//  Progress Note 2.1
//
//  Created by Purin Prateepmanowong on 10/29/24.
//

import CoreData
import SwiftUI

class DataManager {
    // Singleton instance
    static let shared = DataManager()
    
    // Reference to Core Data Persistent Container
    let persistentContainer: NSPersistentContainer

    private init() {
        // Initialize the Core Data stack
        persistentContainer = NSPersistentContainer(name: "DoctorsBuddy") // Ensure your Core Data model name matches this string
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    // MARK: - Core Data Save Context
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - Save Progress Note
    func saveProgressNote(for patient: Patient, subjective: String, systolicBP: Int, diastolicBP: Int, heartRate: Int, respiratoryRate: Int, temperature: Double, plan: String) {
        let context = persistentContainer.viewContext
        
        // Create a new ProgressNote instance
        let newNote = ProgressNote(context: context)
        newNote.id = UUID()
        newNote.date = Date()
        newNote.subjective = subjective
        newNote.objectiveSystolicBP = Int16(systolicBP)
        newNote.objectiveDiastolicBP = Int16(diastolicBP)
        newNote.objectiveHeartRate = Int16(heartRate)
        newNote.objectiveRespiratoryRate = Int16(respiratoryRate)
        newNote.objectiveTemperature = temperature
        newNote.plan = plan

        // Establish the relationship with the patient
        newNote.patient = patient
        
        // Add the note to the patient’s progressNotes set
        patient.addToProgressNotes(newNote)
        
        saveContext()
    }
    
    // MARK: - Fetch Patients
    func fetchPatients() -> [Patient] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Patient> = Patient.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching patients: \(error)")
            return []
        }
    }
    
    // MARK: - Create Patient
    func createPatient(hospitalNumber: String, name: String, age: Int, gender: String, contactInfo: String?, medicalHistory: String?) {
        let context = persistentContainer.viewContext
        let patient = Patient(context: context)

        patient.id = UUID()
        patient.hospitalNumber = hospitalNumber
        patient.name = name
        patient.age = Int16(age)
        patient.gender = gender
        patient.contactInfo = contactInfo
        patient.medicalHistory = medicalHistory

        saveContext()
    }
    
    // MARK: - Update ProgressNote
    func updateProgressNote(_ note: ProgressNote, withData data: [String: Any]) {
        note.subjective = data["subjective"] as? String ?? ""
        note.objectiveSystolicBP = data["objectiveSystolicBP"] as? Int16 ?? 120
        note.objectiveDiastolicBP = data["objectiveDiastolicBP"] as? Int16 ?? 80
        note.objectiveHeartRate = data["objectiveHeartRate"] as? Int16 ?? 70
        note.objectiveRespiratoryRate = data["objectiveRespiratoryRate"] as? Int16 ?? 16
        note.objectiveTemperature = data["objectiveTemperature"] as? Double ?? 98.6
        note.plan = data["plan"] as? String ?? ""

        saveContext()
    }
    
    // MARK: - Delete Patient
    func deletePatient(_ patient: Patient) {
        persistentContainer.viewContext.delete(patient)
        saveContext()
    }
}



