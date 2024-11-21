//
//  PatientProgressGraphView.swift
//  Progress Note 2.1
//
//  Created by Purin Prateepmanowong on 11/10/24.
//

import SwiftUI

struct PatientProgressGraphView: View {
    var patient: Patient  // Pass patient data into the view

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Progress Graphs")
                    .font(.title)
                    .padding()

                // Temperature Graph
                if !temperatureData.isEmpty {
                    Text("Temperature")
                        .font(.headline)
                    LineChart(dataPoints: temperatureData)
                        .frame(height: 200)
                        .padding()
                }

                // Heart Rate Graph
                if !heartRateData.isEmpty {
                    Text("Heart Rate")
                        .font(.headline)
                    LineChart(dataPoints: heartRateData.map { ($0.0, Double($0.1)) }) // Convert Int to Double
                        .frame(height: 200)
                        .padding()
                }

                // Systolic BP Graph
                if !systolicBPData.isEmpty {
                    Text("Systolic Blood Pressure")
                        .font(.headline)
                    LineChart(dataPoints: systolicBPData.map { ($0.0, Double($0.1)) })
                        .frame(height: 200)
                        .padding()
                }

                // Diastolic BP Graph
                if !diastolicBPData.isEmpty {
                    Text("Diastolic Blood Pressure")
                        .font(.headline)
                    LineChart(dataPoints: diastolicBPData.map { ($0.0, Double($0.1)) })
                        .frame(height: 200)
                        .padding()
                }

                // Respiratory Rate Graph
                if !respiratoryRateData.isEmpty {
                    Text("Respiratory Rate")
                        .font(.headline)
                    LineChart(dataPoints: respiratoryRateData.map { ($0.0, Double($0.1)) })
                        .frame(height: 200)
                        .padding()
                }
            }
            .navigationTitle("Progress Graphs")
            .padding()
        }
    }

    // Data extraction for charts
    private var temperatureData: [(Date, Double)] {
        patient.progressNotesArray.compactMap { note in
            guard let date = note.date else { return nil }
            return (date, note.objectiveTemperature)
        }
    }

    private var heartRateData: [(Date, Int)] {
        patient.progressNotesArray.compactMap { note in
            guard let date = note.date else { return nil }
            return (date, Int(note.objectiveHeartRate))
        }
    }

    private var systolicBPData: [(Date, Int)] {
        patient.progressNotesArray.compactMap { note in
            guard let date = note.date else { return nil }
            return (date, Int(note.objectiveSystolicBP))
        }
    }

    private var diastolicBPData: [(Date, Int)] {
        patient.progressNotesArray.compactMap { note in
            guard let date = note.date else { return nil }
            return (date, Int(note.objectiveDiastolicBP))
        }
    }

    private var respiratoryRateData: [(Date, Int)] {
        patient.progressNotesArray.compactMap { note in
            guard let date = note.date else { return nil }
            return (date, Int(note.objectiveRespiratoryRate))
        }
    }
    
}

// Helper function to convert NSSet of ProgressNotes to an array in Patient
extension Patient {
    var progressNotesArray: [ProgressNote] {
        (progressNotes?.allObjects as? [ProgressNote]) ?? []
    }
}

struct PatientProgressGraphView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let samplePatient = Patient(context: context)
        
        // Add sample data
        let sampleNote1 = ProgressNote(context: context)
        sampleNote1.date = Date()
        sampleNote1.objectiveTemperature = 98.6
        sampleNote1.objectiveHeartRate = 72
        sampleNote1.objectiveSystolicBP = 120
        sampleNote1.objectiveDiastolicBP = 80
        sampleNote1.objectiveRespiratoryRate = 16
        
        let sampleNote2 = ProgressNote(context: context)
        sampleNote2.date = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        sampleNote2.objectiveTemperature = 99.0
        sampleNote2.objectiveHeartRate = 75
        sampleNote2.objectiveSystolicBP = 118
        sampleNote2.objectiveDiastolicBP = 78
        sampleNote2.objectiveRespiratoryRate = 18
        
        samplePatient.addToProgressNotes(sampleNote1)
        samplePatient.addToProgressNotes(sampleNote2)

        return NavigationView {
            PatientProgressGraphView(patient: samplePatient)
                .environment(\.managedObjectContext, context)
        }
    }
}




