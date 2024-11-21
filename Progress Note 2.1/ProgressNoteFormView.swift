import SwiftUI

struct ProgressNoteFormView: View {
    @Binding var creationDate: Date
    @Binding var subjective: String
    @Binding var systolicBP: String
    @Binding var diastolicBP: String
    @Binding var heartRate: String
    @Binding var respiratoryRate: String
    @Binding var temperature: String
    @Binding var generalAppearance: String
    @Binding var htHead: String
    @Binding var htEar: String
    @Binding var htEyes: String
    @Binding var htNose: String
    @Binding var htThroat: String
    @Binding var cvs: String
    @Binding var rs: String
    @Binding var abdomen: String
    @Binding var extremities: String
    @Binding var neuroExam: String
    @Binding var pelvicExam: String
    @Binding var prExam: String
    @Binding var investigations: String
    @Binding var clinicalStatus: ClinicalStatus
    @Binding var plan: String
    @Binding var eyeOpeningScore: String
    @Binding var verbalResponseScore: String
    @Binding var motorResponseScore: String
    @Binding var problems: [Problem]
    let eyeOpeningCases: [String]
    let verbalResponseCases: [String]
    let motorResponseCases: [String]
    var previousDayProgressNote: ProgressNote? // Add the previous day's note as an optional input
    var isEditable: Bool

    var body: some View {
        Form {
            // Button to Copy Data from Previous Day
            if let previousNote = previousDayProgressNote {
                Button("Copy Data from Previous Day") {
                    copyData(from: previousNote)
                }
                .padding()
            }
            
            // Date Selection
            Section(header: Text("Creation Date")) {
                DatePicker("Date", selection: $creationDate, displayedComponents: .date)
                    .disabled(!isEditable)
            }
            
            // Subjective
            Section(header: Text("Subjective")) {
                TextField("Subjective", text: $subjective)
                    .disabled(!isEditable)
            }
            
            // Vital Signs
            Section(header: Text("Vital Signs")) {
                TextField("Systolic BP", text: $systolicBP)
                    .disabled(!isEditable)
                TextField("Diastolic BP", text: $diastolicBP)
                    .disabled(!isEditable)
                TextField("Heart Rate", text: $heartRate)
                    .disabled(!isEditable)
                TextField("Respiratory Rate", text: $respiratoryRate)
                    .disabled(!isEditable)
                TextField("Temperature", text: $temperature)
                    .disabled(!isEditable)
            }
            
            // General Appearance
            Section(header: Text("General Appearance")) {
                TextEditor(text: $generalAppearance)
                    .disabled(!isEditable)
                    .frame(height: 100)
                    .padding(.horizontal, 4)
            }
            
            // HEENT
            Section(header: Text("HEENT")) {
                TextField("Head", text: $htHead)
                    .disabled(!isEditable)
                TextField("Ear", text: $htEar)
                    .disabled(!isEditable)
                TextField("Eyes", text: $htEyes)
                    .disabled(!isEditable)
                TextField("Nose", text: $htNose)
                    .disabled(!isEditable)
                TextField("Throat", text: $htThroat)
                    .disabled(!isEditable)
            }
            
            // EVM Score
            Section(header: Text("EVM Score")) {
                VStack(alignment: .leading) {
                    Text("Eye Opening Score")
                        .font(.headline)
                    HStack {
                        ForEach(eyeOpeningCases, id: \.self) { score in
                            Button(action: {
                                eyeOpeningScore = score
                            }) {
                                Text(score)
                                    .padding()
                                    .background(eyeOpeningScore == score ? Color.blue.opacity(0.3) : Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .disabled(!isEditable)
                        }
                    }
                    
                    Text("Verbal Response Score")
                        .font(.headline)
                    HStack {
                        ForEach(verbalResponseCases, id: \.self) { score in
                            Button(action: {
                                verbalResponseScore = score
                            }) {
                                Text(score)
                                    .padding()
                                    .background(verbalResponseScore == score ? Color.blue.opacity(0.3) : Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .disabled(!isEditable)
                        }
                    }
                    
                    Text("Motor Response Score")
                        .font(.headline)
                    HStack {
                        ForEach(motorResponseCases, id: \.self) { score in
                            Button(action: {
                                motorResponseScore = score
                            }) {
                                Text(score)
                                    .padding()
                                    .background(motorResponseScore == score ? Color.blue.opacity(0.3) : Color.gray.opacity(0.2))
                                    .cornerRadius(8)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .disabled(!isEditable)
                        }
                    }
                }
            }
            
            // Plan
            Section(header: Text("Plan")) {
                TextEditor(text: $plan)
                    .disabled(!isEditable)
                    .frame(height: 100)
                    .padding(.horizontal, 4)
            }
            
            // Problem List
            Section(header: Text("Problem List")) {
                ForEach(problems.indices, id: \.self) { index in
                    VStack(alignment: .leading) {
                        TextField("Problem Description", text: $problems[index].description)
                            .disabled(!isEditable)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        HStack {
                            ForEach(ClinicalStatus.allCases, id: \.self) { status in
                                Button(action: {
                                    problems[index].clinicalStatus = status
                                }) {
                                    Text(status.rawValue)
                                        .padding()
                                        .background(problems[index].clinicalStatus == status ? Color.blue.opacity(0.3) : Color.gray.opacity(0.2))
                                        .cornerRadius(8)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                .disabled(!isEditable)
                            }
                            
                            Spacer()
                            
                            if isEditable {
                                Button(action: {
                                    deleteProblem(at: index)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                }
                
                if isEditable {
                    Button(action: addProblem) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Problem")
                        }
                        .foregroundColor(.blue)
                        .padding()
                    }
                }
            }
        }
    }
    
    private func copyData(from previousNote: ProgressNote) {
        subjective = previousNote.subjective ?? ""
        systolicBP = String(previousNote.objectiveSystolicBP) // Direct conversion for Int16
        diastolicBP = String(previousNote.objectiveDiastolicBP) // Direct conversion for Int16
        heartRate = String(previousNote.objectiveHeartRate) // Direct conversion for Int16
        respiratoryRate = String(previousNote.objectiveRespiratoryRate) // Direct conversion for Int16
        temperature = String(format: "%.1f", previousNote.objectiveTemperature) // Format for Double
        generalAppearance = previousNote.generalAppearance ?? ""
        htHead = previousNote.htHead ?? ""
        htEar = previousNote.htEar ?? ""
        htEyes = previousNote.htEyes ?? ""
        htNose = previousNote.htNose ?? ""
        htThroat = previousNote.htThroat ?? ""
        cvs = previousNote.cvs ?? ""
        rs = previousNote.rs ?? ""
        abdomen = previousNote.abdomen ?? ""
        extremities = previousNote.extremities ?? ""
        neuroExam = previousNote.neuroExam ?? ""
        pelvicExam = previousNote.pelvicExam ?? ""
        prExam = previousNote.prExam ?? ""
        investigations = previousNote.investigations ?? ""
        plan = previousNote.plan ?? ""
        problems = previousNote.problemList?.allObjects.compactMap { obj in
            guard let managedProblem = obj as? ManagedProblem else { return nil }
            return Problem(
                description: managedProblem.descriptionP ?? "",
                clinicalStatus: ClinicalStatus(rawValue: managedProblem.clinicalStatus ?? "") ?? .stable
            )
        } ?? []
    }
    
    private func addProblem() {
        problems.append(Problem(description: "New Problem", clinicalStatus: .stable))
    }
    
    private func deleteProblem(at index: Int) {
        problems.remove(at: index)
    }
}

struct ProgressNoteFormView_Previews: PreviewProvider {
    @State static var creationDate = Date()
    @State static var subjective = "Feeling better"
    @State static var systolicBP = "120"
    @State static var diastolicBP = "80"
    @State static var heartRate = "70"
    @State static var respiratoryRate = "16"
    @State static var temperature = "98.6"
    @State static var generalAppearance = "Good"
    @State static var htHead = "Normal"
    @State static var htEar = "Clear"
    @State static var htEyes = "Normal"
    @State static var htNose = "Clear"
    @State static var htThroat = "Normal"
    @State static var cvs = "Normal"
    @State static var rs = "Clear"
    @State static var abdomen = "Soft"
    @State static var extremities = "No edema"
    @State static var neuroExam = "Intact"
    @State static var pelvicExam = "Normal"
    @State static var prExam = "Normal"
    @State static var investigations = "Blood sugar normal"
    @State static var clinicalStatus = ClinicalStatus.stable
    @State static var plan = "Administer additional medication"
    @State static var eyeOpeningScore = "4"
    @State static var verbalResponseScore = "5"
    @State static var motorResponseScore = "6"
    @State static var problems: [Problem] = [
        Problem(description: "Fever", clinicalStatus: .improved),
        Problem(description: "Cough", clinicalStatus: .stable)
    ]
    
    static var previews: some View {
        ProgressNoteFormView(
            creationDate: $creationDate,
            subjective: $subjective,
            systolicBP: $systolicBP,
            diastolicBP: $diastolicBP,
            heartRate: $heartRate,
            respiratoryRate: $respiratoryRate,
            temperature: $temperature,
            generalAppearance: $generalAppearance,
            htHead: $htHead,
            htEar: $htEar,
            htEyes: $htEyes,
            htNose: $htNose,
            htThroat: $htThroat,
            cvs: $cvs,
            rs: $rs,
            abdomen: $abdomen,
            extremities: $extremities,
            neuroExam: $neuroExam,
            pelvicExam: $pelvicExam,
            prExam: $prExam,
            investigations: $investigations,
            clinicalStatus: $clinicalStatus,
            plan: $plan, // Add the missing 'plan' binding
            eyeOpeningScore: $eyeOpeningScore,
            verbalResponseScore: $verbalResponseScore,
            motorResponseScore: $motorResponseScore,
            problems: $problems,
            eyeOpeningCases: ["1", "2", "3", "4"],
            verbalResponseCases: ["1", "2", "3", "4", "5"],
            motorResponseCases: ["1", "2", "3", "4", "5", "6"],
            isEditable: true
        )
    }
}




