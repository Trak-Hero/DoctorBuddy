//
//  AuthManager.swift
//  Progress Note 2.1
//
//  Created by Purin Prateepmanowong on 10/29/24.
//

import SwiftUI
import Combine
import LocalAuthentication

class AuthManager: ObservableObject {
    @Published var isAuthenticated = false
    
    private let storedEmailKey = "storedEmail"
    private let storedPasswordKey = "storedPassword"
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Access your notes") { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isAuthenticated = true
                    } else {
                        self.isAuthenticated = false
                    }
                }
            }
        } else {
            self.isAuthenticated = false
        }
    }
    
    func login(email: String, password: String) {
        let storedEmail = UserDefaults.standard.string(forKey: storedEmailKey)
        let storedPassword = UserDefaults.standard.string(forKey: storedPasswordKey)
        
        if email == storedEmail && password == storedPassword {
            isAuthenticated = true
        } else {
            isAuthenticated = false
        }
    }
    
    func signUp(email: String, password: String) {
        UserDefaults.standard.set(email, forKey: storedEmailKey)
        UserDefaults.standard.set(password, forKey: storedPasswordKey)
        isAuthenticated = true
    }
    
    func logout() {
        isAuthenticated = false
    }
}




