//
//  PersistenceController.swift
//  Progress Note 2.1
//
//  Created by Purin Prateepmanowong on 10/29/24.
//

import CoreData
import Foundation

struct PersistenceController {
    static let shared = PersistenceController()
    
    // In-memory container for SwiftUI previews
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext

        // Sample data for preview
        let samplePatient = Patient(context: viewContext)
        samplePatient.name = "John Doe"
        samplePatient.age = 45
        samplePatient.contactInfo = "123-456-7890"
        samplePatient.medicalHistory = "Hypertension, Diabetes"

        let sampleNote = ProgressNote(context: viewContext)
        sampleNote.date = Date()
        sampleNote.plan = "Follow-up in two weeks."
        samplePatient.addToProgressNotes(sampleNote)
        
        do {
            try viewContext.save()
        } catch {
            print("Failed to save preview data: \(error)")
        }
        
        return controller
    }()
    
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Progress_Note_2_1") // Ensure this matches your model name
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}



