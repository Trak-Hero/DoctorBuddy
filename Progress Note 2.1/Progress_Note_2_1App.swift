//
//  Progress_Note_2_1App.swift
//  Progress Note 2.1
//
//  Created by Purin Prateepmanowong on 10/29/24.
//

import SwiftUI

@main
struct Progress_Note_2_1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
