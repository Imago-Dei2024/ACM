//
//  SettingsView.swift
//  ACM2
//
//  Created by Connor Laber on 6/12/25.
//
//  Displays app settings and includes the logout functionality.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authManager: AuthManager // Inject the AuthManager

    var body: some View {
        NavigationView {
            List {
                // Account settings section
                Section("Account") {
                    SettingsRow(icon: "person.circle", title: "Account Info", color: .blue)
                    SettingsRow(icon: "lock", title: "Privacy", color: .green)
                    SettingsRow(icon: "bell", title: "Notifications", color: .orange)
                }
                
                // App settings section
                Section("App") {
                    SettingsRow(icon: "paintbrush", title: "Theme", color: .purple)
                    SettingsRow(icon: "textformat", title: "Text Size", color: .blue)
                    SettingsRow(icon: "globe", title: "Language", color: .green)
                }
                
                // Support section
                Section("Support") {
                    SettingsRow(icon: "questionmark.circle", title: "Help", color: .orange)
                    SettingsRow(icon: "envelope", title: "Feedback", color: .blue)
                    SettingsRow(icon: "star", title: "Rate App", color: .yellow)
                }
                
                // Logout section
                Section {
                    // In SettingsView.swift

                    Button(action: {
                        Task {
                            await authManager.signOut()
                        }
                    }) {
                        // ...
                    }
                        HStack {
                            Spacer()
                            Text("Log Out")
                                .foregroundColor(.red)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }

