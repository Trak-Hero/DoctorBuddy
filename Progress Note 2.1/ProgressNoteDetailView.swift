//
//  ProgressNoteDetailView.swift
//  Progress Note 2.1
//
//  Created by Purin Prateepmanowong on 10/29/24.
//

import SwiftUI
import CoreData

struct ProgressNoteDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var progressNote: ProgressNote
    struct EVMScores {
        static let eyeOpeningCases = ["1", "2", "3", "4"]
        static let verbalResponseCases = ["1", "2", "3", "4", "5"]
        static let motorResponseCases = ["1", "2", "3", "4", "5", "6"]
    }
    

    @State private var problems: [Problem] = []
    @State private var subjective: String = ""
    @State private var systolicBP: String = ""
    @State private var diastolicBP: String = ""
    @State private var heartRate: String = ""
    @State private var respiratoryRate: String = ""
    @State private var temperature: String = ""
    @State private var generalAppearance: String = ""
    @State private var htHead: String = ""
    @State private var htEyes: String = ""
    @State private var htNose: String = ""
    @State private var htThroat: String = ""
    @State private var cvs: String = ""
    @State private var rs: String = ""
    @State private var abdomen: String = ""
    @State private var extremities: String = ""
    @State private var neuroExam: String = ""
    @State private var pelvicExam: String = ""
    @State private var prExam: String = ""
    @State private var investigations: String = ""
    @State private var clinicalStatus: ClinicalStatus = .stable
    @State private var eyeOpeningScore: String = "NT"
    @State private var verbalResponseScore: String = "NT"
    @State private var motorResponseScore: String = "NT"

    var body: some View {
        Form {
            Section(header: Text("Subjective")) {
                TextField("Subjective", text: $subjective)
            }

            Section(header: Text("Vital Signs")) {
                TextField("Systolic BP", text: $systolicBP)
                TextField("Diastolic BP", text: $diastolicBP)
                TextField("Heart Rate", text: $heartRate)
                TextField("Respiratory Rate", text: $respiratoryRate)
                TextField("Temperature", text: $temperature)
            }

            Section(header: Text("Physical Exam")) {
                TextField("General Appearance", text: $generalAppearance)
                TextField("Head", text: $htHead)
                TextField("Eyes", text: $htEyes)
                TextField("Nose", text: $htNose)
                TextField("Throat", text: $htThroat)
                TextField("CVS", text: $cvs)
                TextField("RS", text: $rs)
                TextField("Abdomen", text: $abdomen)
                TextField("Extremities", text: $extremities)
                TextField("Neuro Exam", text: $neuroExam)
                TextField("Pelvic Exam", text: $pelvicExam)
                TextField("PR Exam", text: $prExam)
                TextField("Investigations", text: $investigations)
            }

            Section(header: Text("EVM Scores")) {
                Picker("Eye Opening", selection: $eyeOpeningScore) {
                    ForEach(EVMScores.eyeOpeningCases, id: \.self) { score in
                        Text(score).tag(score)
                    }
                }
                Picker("Verbal Response", selection: $verbalResponseScore) {
                    ForEach(EVMScores.verbalResponseCases, id: \.self) { score in
                        Text(score).tag(score)
                    }
                }
                Picker("Motor Response", selection: $motorResponseScore) {
                    ForEach(EVMScores.motorResponseCases, id: \.self) { score in
                        Text(score).tag(score)
                    }
                }
            }

            Section(header: Text("Problem List")) {
                ForEach($problems) { $problem in
                    HStack {
                        TextField("Description", text: $problem.description)
                        Picker("", selection: $problem.clinicalStatus) {
                            ForEach(ClinicalStatus.allCases, id: \.self) { status in
                                Text(status.rawValue).tag(status)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        Spacer()
                        Button(action: {
                            deleteProblem(problem)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
        }
        .onAppear {
            loadProgressNoteDetails()
        }
        .navigationTitle("Progress Note Details")
        .navigationBarItems(trailing: Button("Save") {
            saveProgressNote()
        })
    }

    private func loadProgressNoteDetails() {
        subjective = progressNote.subjective ?? ""
        systolicBP = String(progressNote.objectiveSystolicBP)
        diastolicBP = String(progressNote.objectiveDiastolicBP)
        heartRate = String(progressNote.objectiveHeartRate)
        respiratoryRate = String(progressNote.objectiveRespiratoryRate)
        temperature = String(progressNote.objectiveTemperature)
        generalAppearance = progressNote.generalAppearance ?? ""
        htHead = progressNote.htHead ?? ""
        htEyes = progressNote.htEyes ?? ""
        htNose = progressNote.htNose ?? ""
        htThroat = progressNote.htThroat ?? ""
        cvs = progressNote.cvs ?? ""
        rs = progressNote.rs ?? ""
        abdomen = progressNote.abdomen ?? ""
        extremities = progressNote.extremities ?? ""
        neuroExam = progressNote.neuroExam ?? ""
        pelvicExam = progressNote.pelvicExam ?? ""
        prExam = progressNote.prExam ?? ""
        investigations = progressNote.investigations ?? ""
        clinicalStatus = ClinicalStatus(rawValue: progressNote.clinicalStatus ?? "") ?? .stable
        eyeOpeningScore = progressNote.evmEYE ?? "NT"
        verbalResponseScore = progressNote.evmVerbal ?? "NT"
        motorResponseScore = progressNote.evmMOTOR ?? "NT"
        problems = progressNote.problemListArray.map { managedProblem in
                Problem(
                    description: managedProblem.descriptionP ?? "",
                    clinicalStatus: ClinicalStatus(rawValue: managedProblem.clinicalStatus ?? "") ?? .stable
                )
            }
    }

    private func saveProgressNote() {
        progressNote.subjective = subjective
        progressNote.objectiveSystolicBP = Int16(systolicBP) ?? 0
        progressNote.objectiveDiastolicBP = Int16(diastolicBP) ?? 0
        progressNote.objectiveHeartRate = Int16(heartRate) ?? 0
        progressNote.objectiveRespiratoryRate = Int16(respiratoryRate) ?? 0
        progressNote.objectiveTemperature = Double(temperature) ?? 0.0
        progressNote.generalAppearance = generalAppearance
        progressNote.htHead = htHead
        progressNote.htEyes = htEyes
        progressNote.htNose = htNose
        progressNote.htThroat = htThroat
        progressNote.cvs = cvs
        progressNote.rs = rs
        progressNote.abdomen = abdomen
        progressNote.extremities = extremities
        progressNote.neuroExam = neuroExam
        progressNote.pelvicExam = pelvicExam
        progressNote.prExam = prExam
        progressNote.investigations = investigations
        progressNote.clinicalStatus = clinicalStatus.rawValue
        progressNote.evmEYE = eyeOpeningScore
        progressNote.evmVerbal = verbalResponseScore
        progressNote.evmMOTOR = motorResponseScore

        // Save problem list
        progressNote.problemList = NSSet(array: problems.map { problem in
            let managedProblem = ManagedProblem(context: viewContext)
            managedProblem.descriptionP = problem.description
            managedProblem.clinicalStatus = problem.clinicalStatus.rawValue
            return managedProblem
        })

        do {
            try viewContext.save()
            print("Progress note saved successfully.")
        } catch {
            print("Error saving progress note: \(error)")
        }
    }

    private func deleteProblem(_ problem: Problem) {
        problems.removeAll { $0.id == problem.id }
    }
}

struct ProgressNoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let sampleNote = ProgressNote(context: context)
        sampleNote.subjective = "Patient feels better."
        sampleNote.generalAppearance = "Good"
        return NavigationView {
            ProgressNoteDetailView(progressNote: sampleNote)
                .environment(\.managedObjectContext, context)
        }
    }
}



