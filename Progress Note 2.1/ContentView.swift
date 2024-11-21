//
//  ContentView.swift
//  Progress Note 2.1
//
//  Created by Purin Prateepmanowong on 10/29/24.
//

// ContentView.swift
// Ensure AuthManager is provided to ContentView properly

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager // Access AuthManager

    var body: some View {
        Group {
            if authManager.isAuthenticated {
                PatientListView() // Main app content
                    .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            } else {
                LoginView() // Show login or signup page
                    .environmentObject(authManager) // Pass AuthManager to login view
            }
        }
        .onAppear {
            authManager.isAuthenticated = false // Ensure authentication state resets at app start
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthManager())
    }
}





