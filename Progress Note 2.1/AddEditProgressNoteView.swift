import SwiftUI

struct AddEditProgressNoteView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var patient: Patient
    
    @State private var creationDate = Date()
    @State private var subjective = ""
    @State private var systolicBP = ""
    @State private var diastolicBP = ""
    @State private var heartRate = ""
    @State private var respiratoryRate = ""
    @State private var temperature = ""
    @State private var generalAppearance = ""
    @State private var htHead = ""
    @State private var htEar = ""
    @State private var htEyes = ""
    @State private var htNose = ""
    @State private var htThroat = ""
    @State private var cvs = ""
    @State private var rs = ""
    @State private var abdomen = ""
    @State private var extremities = ""
    @State private var neuroExam = ""
    @State private var pelvicExam = ""
    @State private var prExam = ""
    @State private var investigations = ""
    @State private var clinicalStatus = ClinicalStatus.stable
    @State private var eyeOpeningScore = "NT"
    @State private var verbalResponseScore = "NT"
    @State private var motorResponseScore = "NT"
    @State private var problems: [Problem] = [Problem(description: "Example problem", clinicalStatus: .stable)]
    @State private var plan = ""
    
    private var previousDayProgressNote: ProgressNote? {
            patient.progressNotesArray.last { $0.date ?? Date.distantPast < creationDate }
        }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let previousNote = previousDayProgressNote {
                    Button("Copy Data from Previous Day") {
                        copyData(from: previousNote)
                    }
                    .padding()
                    .buttonStyle(PrimaryButtonStyle())
                }
                // Date Picker
                DatePicker("Date", selection: $creationDate, displayedComponents: .date)
                    .padding()
                
                // Subjective
                SectionHeaderView(title: "Subjective")
                TextEditor(text: $subjective)
                    .frame(height: 100)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                
                // Vital Signs
                SectionHeaderView(title: "Vital Signs")
                Group {
                    HStack {
                        TextField("Systolic BP", text: $systolicBP)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Diastolic BP", text: $diastolicBP)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    HStack {
                        TextField("Heart Rate", text: $heartRate)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Respiratory Rate", text: $respiratoryRate)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    TextField("Temperature", text: $temperature)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                
                // General Appearance
                SectionHeaderView(title: "General Appearance")
                TextEditor(text: $generalAppearance)
                    .frame(height: 100)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                
                // Head and Throat
                SectionHeaderView(title: "HEENT")
                Group {
                    TextField("Head",text: $htHead)
                        .frame(height: 30)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    
                    TextField("Ear",text: $htEar)
                        .frame(height: 30)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    
                    TextField("Eyes",text: $htEyes)
                        .frame(height: 30)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    
                    TextField("Nose",text: $htNose)
                        .frame(height: 30)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                    
                    TextField("Throat",text: $htThroat)
                        .frame(height: 30)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                }
                
                // Examinations Section
                SectionHeaderView(title: "Examinations")
                Group {
                    TextField("Cardio Vascular System", text: $cvs)
                        .frame(height: 60)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))

                    TextField("Respiratory System", text: $rs)
                        .frame(height: 60)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))

                    TextField("Abdomen", text: $abdomen)
                        .frame(height: 60)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))

                    TextField("Extremities", text: $extremities)
                        .frame(height: 60)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))

                    // Neurological Examination
                    SectionHeaderView(title: "Neurological Examination")
                    TextEditor(text: $neuroExam)
                        .frame(height: 100)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))

                    // Investigations
                    SectionHeaderView(title: "Investigations")
                    TextEditor(text: $investigations)
                        .frame(height: 100)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                }
                .padding()

                // File Upload Section
                SectionHeaderView(title: "Optional File Uploads")
                Group {
                    // Pelvic Exam File Upload
                    VStack(alignment: .leading) {
                        Text("Upload Pelvic Exam File")
                            .font(.headline)
                        Button(action: {
                            // Action to upload file for pelvic exam
                            print("Pelvic exam file uploaded.")
                        }) {
                            HStack {
                                Image(systemName: "doc.fill.badge.plus")
                                Text("Upload Pelvic Exam File")
                            }
                        }
                        .buttonStyle(PrimaryButtonStyle())
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.bottom, 10)

                    // Rectal Exam File Upload
                    VStack(alignment: .leading) {
                        Text("Upload Rectal Exam File")
                            .font(.headline)
                        Button(action: {
                            // Action to upload file for rectal exam
                            print("Rectal exam file uploaded.")
                        }) {
                            HStack {
                                Image(systemName: "doc.fill.badge.plus")
                                Text("Upload Rectal Exam File")
                            }
                        }
                        .buttonStyle(PrimaryButtonStyle())
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                }
                .padding()

                // EVM Scores
                SectionHeaderView(title: "EVM Scores")
                Group {
                    VStack {
                        Text("Eye Opening Score")
                            .font(.headline)
                        Picker("Eye Opening Score", selection: $eyeOpeningScore) {
                            ForEach(["1", "2", "3", "4", "NT"], id: \.self) { score in
                                Text(score).tag(score)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                    }
                    
                    VStack {
                        Text("Verbal Response Score")
                            .font(.headline)
                        Picker("Verbal Response Score", selection: $verbalResponseScore) {
                            ForEach(["1", "2", "3", "4", "5", "NT"], id: \.self) { score in
                                Text(score).tag(score)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                    }
                    
                    VStack {
                        Text("Motor Response Score")
                            .font(.headline)
                        Picker("Motor Response Score", selection: $motorResponseScore) {
                            ForEach(["1", "2", "3", "4", "5", "6", "NT"], id: \.self) { score in
                                Text(score).tag(score)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                    }
                }
                .padding()

                
                // Problem List
                SectionHeaderView(title: "Problem List")
                ForEach(problems.indices, id: \.self) { index in
                    VStack {
                        HStack {
                            TextField("Problem Description", text: $problems[index].description)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.trailing, 8)

                            Button(action: {
                                problems.remove(at: index)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }

                        Picker("Status", selection: $problems[index].clinicalStatus) {
                            ForEach(ClinicalStatus.allCases, id: \.self) { status in
                                Text(status.rawValue).tag(status)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(8)
                }
                Button(action: {
                    problems.append(Problem(description: "", clinicalStatus: .stable))
                }) {
                    Label("Add Problem", systemImage: "plus.circle")
                }
                .padding()
                
                // Plan
                SectionHeaderView(title: "Plan")
                TextEditor(text: $plan)
                    .frame(height: 100)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                
                // Save Button
                Button("Save") {
                    saveProgressNote()
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding()
            }
            .padding()
        }
        .navigationTitle("Add/Edit Progress Note")
    }
    
    private func copyData(from previousNote: ProgressNote) {
            subjective = previousNote.subjective ?? ""
            systolicBP = String(previousNote.objectiveSystolicBP)
            diastolicBP = String(previousNote.objectiveDiastolicBP)
            heartRate = String(previousNote.objectiveHeartRate)
            respiratoryRate = String(previousNote.objectiveRespiratoryRate)
            temperature = String(format: "%.1f", previousNote.objectiveTemperature)
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
            eyeOpeningScore = previousNote.evmEYE ?? "NT"
            verbalResponseScore = previousNote.evmVerbal ?? "NT"
            motorResponseScore = previousNote.evmMOTOR ?? "NT"
            plan = previousNote.plan ?? ""
            
            // Copy problems
            problems = previousNote.problemList?.allObjects.compactMap { obj in
                guard let managedProblem = obj as? ManagedProblem else { return nil }
                return Problem(
                    description: managedProblem.descriptionP ?? "",
                    clinicalStatus: ClinicalStatus(rawValue: managedProblem.clinicalStatus ?? "") ?? .stable
                )
            } ?? []
        }

    
    private func saveProgressNote() {
        let newNote = ProgressNote(context: viewContext)
        newNote.id = UUID()
        newNote.date = creationDate
        newNote.subjective = subjective
        newNote.objectiveSystolicBP = Int16(systolicBP) ?? 0
        newNote.objectiveDiastolicBP = Int16(diastolicBP) ?? 0
        newNote.objectiveHeartRate = Int16(heartRate) ?? 0
        newNote.objectiveRespiratoryRate = Int16(respiratoryRate) ?? 0
        newNote.objectiveTemperature = Double(temperature) ?? 0.0
        newNote.generalAppearance = generalAppearance
        newNote.htHead = htHead
        newNote.htEar = htEar
        newNote.htEyes = htEyes
        newNote.htNose = htNose
        newNote.htThroat = htThroat
        newNote.cvs = cvs
        newNote.rs = rs
        newNote.abdomen = abdomen
        newNote.extremities = extremities
        newNote.neuroExam = neuroExam
        newNote.pelvicExam = pelvicExam
        newNote.prExam = prExam
        newNote.investigations = investigations
        newNote.clinicalStatus = clinicalStatus.rawValue
        newNote.evmEYE = eyeOpeningScore
        newNote.evmVerbal = verbalResponseScore
        newNote.evmMOTOR = motorResponseScore
        newNote.plan = plan
        
        let managedProblems = problems.map { problem -> ManagedProblem in
            let managedProblem = ManagedProblem(context: viewContext)
            managedProblem.descriptionP = problem.description
            managedProblem.clinicalStatus = problem.clinicalStatus.rawValue
            return managedProblem
        }
        newNote.problemList = NSSet(array: managedProblems)
        patient.addToProgressNotes(newNote)
        
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Failed to save progress note: \(error)")
        }
    }
    
    struct SectionHeaderView: View {
        let title: String
        
        var body: some View {
            Text(title)
                .font(.headline)
                .padding(.top, 10)
        }
    }
    
    struct PrimaryButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .frame(maxWidth: .infinity)
                .background(configuration.isPressed ? Color.blue.opacity(0.7) : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

struct AddEditProgressNoteView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let samplePatient = Patient(context: context)
        samplePatient.name = "John Doe"
        return NavigationView {
            AddEditProgressNoteView(patient: samplePatient)
                .environment(\.managedObjectContext, context)
        }
    }
}
















