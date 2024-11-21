//
//  PatientListView.swift
//  Progress Note 2.1
//
//  Created by Purin Prateepmanowong on 10/29/24.
//

import SwiftUI
import CoreData

struct PatientListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Patient.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Patient.name, ascending: true)]
    ) private var allPatients: FetchedResults<Patient> // Original data source

    @State private var searchText = "" // Search text binding
    @State private var showingAddPatientView = false
    @State private var showingEditPatientView = false
    @State private var selectedPatient: Patient?

    var body: some View {
        NavigationView {
            List {
                // Filter patients based on search text
                ForEach(filteredPatients, id: \.self) { patient in
                    NavigationLink(destination: PatientDetailView(patient: patient)) {
                        Text(patient.name ?? "Unknown") // Safely unwrap optional
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            deletePatient(patient)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }

                        Button {
                            selectedPatient = patient
                            showingEditPatientView = true
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.blue)
                    }
                }
            }
            .navigationTitle("Patients")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddPatientView = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Add Patient")
                }
            }
            .searchable(text: $searchText) // Add a search bar
            .sheet(isPresented: $showingAddPatientView) {
                AddPatientView().environment(\.managedObjectContext, viewContext)
            }
            .sheet(item: $selectedPatient) { patient in
                EditPatientView(patient: patient).environment(\.managedObjectContext, viewContext)
            }
        }
    }

    // Function to filter patients based on search text
    private var filteredPatients: [Patient] {
        if searchText.isEmpty {
            return Array(allPatients)
        } else {
            return allPatients.filter { patient in
                patient.name?.localizedCaseInsensitiveContains(searchText) ?? false
            }
        }
    }

    // Function to delete a patient
    private func deletePatient(_ patient: Patient) {
        viewContext.delete(patient)
        saveContext()
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}

struct PatientListView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        return PatientListView()
            .environment(\.managedObjectContext, context)
    }
}








