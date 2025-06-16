//
//  SettingsView.swift
//  ACM
//
//  Created by Connor Laber on 6/15/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                // Account Settings section
                // Account settings section
                Section("Account") {
                    SettingsRow(icon: "person.circle", title: "Account Info", color: .blue)
                    SettingsRow(icon: "lock", title: "Privacy", color: .green)
                    SettingsRow(icon: "globe", title: "Language", color: .green)
                }
                
                // Support Section
                // Support section
                Section("Support") {
                    SettingsRow(icon: "questionmark.circle", title: "Help", color: .orange)
                    SettingsRow(icon: "envelope", title: "Feedback", color: .blue)
                    Button("Log Out") {
                        // Logout logic would be implemented here
                    }
                    .foregroundStyle(Color.red)
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Done button to dismiss settings
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        
                    }
                }
            }
        }
    }
}
