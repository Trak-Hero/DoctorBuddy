//
//  Progress_Note_2_1App.swift
//  Progress Note 2.1
//
//  Created by Purin Prateepmanowong on 10/29/24.
//

import SwiftUI

@main
struct Progress_Note_2_1App: App {
    @StateObject private var authManager = AuthManager() // Initialize AuthManager

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager) // Provide AuthManager
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}
