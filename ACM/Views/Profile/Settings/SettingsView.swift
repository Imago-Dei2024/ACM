//
//  SettingsView.swift
//  ACM2
//
//  Created by Connor Laber on 6/12/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
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
                    Button("Log Out") {
                        // Logout logic would be implemented here
                    }
                    .foregroundColor(.red)
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
}
