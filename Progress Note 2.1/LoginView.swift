//
//  LoginView.swift
//  Progress Note 2.1
//
//  Created by Purin Prateepmanowong on 10/29/24.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var authManager: AuthManager
    @State private var errorMessage = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // App logo
                Image("APPFINAL") // Replace "APPFINAL" with your image asset name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding(.top, 40)

                // Email and password fields
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                // Login button
                Button("Login") {
                    authManager.login(email: email, password: password)
                }
                .padding()

                // Biometric Authentication button
                Button(action: authenticateWithBiometrics) {
                    HStack {
                        Image(systemName: "faceid") // Use "touchid" for Touch ID
                        Text("Login with Biometrics")
                    }
                }
                .padding()
                .foregroundColor(.blue)

                // Error message display
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                // Navigation link to sign-up page
                NavigationLink(destination: SignUpView().environmentObject(authManager)) {
                    Text("Don't have an account? Sign Up")
                }
                .padding(.bottom, 20)
            }
            .navigationTitle("Log In")
        }
    }

    private func authenticateWithBiometrics() {
        let context = LAContext()
        var error: NSError?

        // Check if biometric authentication is available
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Log in using Face ID or Touch ID"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        // Handle successful authentication
                        authManager.isAuthenticated = true
                    } else {
                        // Handle errors
                        errorMessage = authenticationError?.localizedDescription ?? "Failed to authenticate"
                    }
                }
            }
        } else {
            // Biometrics not available
            errorMessage = error?.localizedDescription ?? "Biometric authentication is not available"
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthManager())
    }
}





