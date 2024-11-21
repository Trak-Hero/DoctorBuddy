//
//  EditPatientView.swift
//  Progress Note 2.1
//
//  Created by Purin Prateepmanowong on 11/8/24.
//

import SwiftUI

struct EditPatientView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    var patient: Patient
    @State private var name: String
    @State private var age: String
    @State private var contactInfo: String
    @State private var medicalHistory: String
    
    init(patient: Patient) {
        self.patient = patient
        _name = State(initialValue: patient.name ?? "")
        _age = State(initialValue: patient.age == 0 ? "" : "\(patient.age)")
        _contactInfo = State(initialValue: patient.contactInfo ?? "")
        _medicalHistory = State(initialValue: patient.medicalHistory ?? "")
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Age", text: $age)
                TextField("Contact Info", text: $contactInfo)
                TextField("Medical History", text: $medicalHistory)
                
                Button("Save") {
                    updatePatient()
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle("Edit Patient")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func updatePatient() {
        patient.name = name
        if let ageInt = Int16(age) {
            patient.age = ageInt
        }
        patient.contactInfo = contactInfo
        patient.medicalHistory = medicalHistory
        
        do {
            try viewContext.save()
            print("Patient updated successfully.")
        } catch {
            print("Failed to update patient: \(error)")
        }
    }
}

