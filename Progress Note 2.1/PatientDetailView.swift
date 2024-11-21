//
//  PatientDetailView.swift
//  Progress Note 2.1
//
//  Created by Purin Prateepmanowong on 10/29/24.
//

import SwiftUI

struct PatientDetailView: View {
    var patient: Patient
    @State private var showingAddProgressNoteView = false
    @State private var showingProgressGraph = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Display patient's name, age, and contact information
            Text(patient.name ?? "Unknown")
                .font(.largeTitle)
                .padding(.bottom, 10)

            Text("Age: \(patient.age)")
                .font(.title2)

            if let contactInfo = patient.contactInfo {
                Text("Contact Info: \(contactInfo)")
                    .font(.body)
            }

            if let medicalHistory = patient.medicalHistory {
                Text("Medical History: \(medicalHistory)")
                    .font(.body)
                    .padding(.top, 10)
            }

            // Additional section for patient details
            Text("Progress Notes")
                .font(.headline)
                .padding(.top, 20)

            // List of Progress Notes grouped by Date
            List {
                ForEach(groupedProgressNotesByDate(), id: \.key) { date, notes in
                    Section(header: Text(date, formatter: DateFormatter.mediumStyle())) {
                        ForEach(notes, id: \.self) { note in
                            NavigationLink(destination: ProgressNoteDetailView(progressNote: note)) {
                                VStack(alignment: .leading) {
                                    Text("Plan: \(note.plan ?? "N/A")")
                                        .font(.subheadline)
                                    Text("Subjective: \(note.subjective ?? "N/A")")
                                        .font(.body)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.top, 10)

            // Button to Add Progress Note
            Button("Add Progress Note") {
                showingAddProgressNoteView.toggle()
            }
            .sheet(isPresented: $showingAddProgressNoteView) {
                AddEditProgressNoteView(patient: patient)
                    .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            }
            .padding()

            // Button to View Progress Graphs
            Button("View Progress Graphs") {
                showingProgressGraph.toggle()
            }
            .sheet(isPresented: $showingProgressGraph) {
                PatientProgressGraphView(patient: patient)
                    .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            }
            .padding()
        }
        .padding()
        .navigationTitle("Patient Details")
    }

    // Helper function to group progress notes by date
    private func groupedProgressNotesByDate() -> [(key: Date, value: [ProgressNote])] {
        let notes = patient.progressNotesArray.sorted { $0.date ?? Date() < $1.date ?? Date() }
        let grouped = Dictionary(grouping: notes) { note -> Date in
            Calendar.current.startOfDay(for: note.date ?? Date())
        }
        return grouped.sorted { $0.key < $1.key }
    }
}


// DateFormatter extension for medium date style
extension DateFormatter {
    static func mediumStyle() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

struct PatientDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let samplePatient = Patient(context: context)
        samplePatient.name = "John Doe"
        samplePatient.age = 45
        samplePatient.contactInfo = "123-456-7890"
        samplePatient.medicalHistory = "Hypertension, Diabetes"

        // Create a sample Progress Note for preview
        let sampleNote = ProgressNote(context: context)
        sampleNote.date = Date()
        sampleNote.plan = "Follow-up in two weeks."
        sampleNote.subjective = "Patient feels better."
        samplePatient.addToProgressNotes(sampleNote)

        return NavigationView {
            PatientDetailView(patient: samplePatient)
                .environment(\.managedObjectContext, context)
        }
    }
}






