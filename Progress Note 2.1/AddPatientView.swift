//
//  AddPatientView.swift
//  Progress Note 2.1
//
//  Created by Purin Prateepmanowong on 11/8/24.
//

import SwiftUI

struct AddPatientView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var contactInfo: String = ""
    @State private var medicalHistory: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Age", text: $age)
                TextField("Contact Info", text: $contactInfo)
                TextField("Medical History", text: $medicalHistory)
                
                Button("Save") {
                    addPatient()
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle("Add New Patient")
            .navigationBarItems(trailing: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func addPatient() {
        let newPatient = Patient(context: viewContext)
        newPatient.name = name
        if let ageInt = Int16(age) {
            newPatient.age = ageInt
        }
        newPatient.contactInfo = contactInfo
        newPatient.medicalHistory = medicalHistory
        
        do {
            try viewContext.save()
            print("Patient added successfully.")
        } catch {
            print("Failed to save new patient: \(error)")
        }
    }
}
