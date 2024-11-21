//
//  SettingsView.swift
//  Progress Note 2.1
//
//  Created by Purin Prateepmanowong on 10/29/24.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authManager: AuthManager  // Access AuthManager to handle logout
    @State private var showingLogoutAlert = false
    @State private var showingPasswordChangeSheet = false
    @State private var showingProfileUpdateSheet = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Account Settings")) {
                    Button(action: {
                        showingProfileUpdateSheet = true
                    }) {
                        Text("Update Profile")
                    }
                    .sheet(isPresented: $showingProfileUpdateSheet) {
                        UpdateProfileView()
                    }
                    
                    Button(action: {
                        showingPasswordChangeSheet = true
                    }) {
                        Text("Change Password")
                    }
                    .sheet(isPresented: $showingPasswordChangeSheet) {
                        ChangePasswordView()
                    }
                    
                    Button(action: {
                        showingLogoutAlert = true
                    }) {
                        Text("Log Out")
                            .foregroundColor(.red)
                    }
                    .alert(isPresented: $showingLogoutAlert) {
                        Alert(
                            title: Text("Log Out"),
                            message: Text("Are you sure you want to log out?"),
                            primaryButton: .destructive(Text("Log Out")) {
                                authManager.logout()
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct UpdateProfileView: View {
    // Add properties for updating profile info here
    @State private var username: String = ""
    @State private var email: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile Information")) {
                    TextField("Username", text: $username)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                }
                
                Button("Save") {
                    // Implement save functionality for updating profile here
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .navigationTitle("Update Profile")
            .navigationBarItems(trailing: Button("Cancel") {
                // Dismiss the view when cancel is tapped
            })
        }
    }
}

struct ChangePasswordView: View {
    // Add properties for changing password here
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Change Password")) {
                    SecureField("Current Password", text: $currentPassword)
                    SecureField("New Password", text: $newPassword)
                    SecureField("Confirm New Password", text: $confirmPassword)
                }
                
                Button("Save New Password") {
                    // Implement password change functionality here
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .navigationTitle("Change Password")
            .navigationBarItems(trailing: Button("Cancel") {
                // Dismiss the view when cancel is tapped
            })
        }
    }
}
