import SwiftUI

    struct SettingsView: View {
        // Access the AuthViewModel from the environment
        @EnvironmentObject var authViewModel: AuthViewModel
        // Access the presentation mode to dismiss the sheet after logout
        @Environment(\.presentationMode) var presentationMode

        var body: some View {
            NavigationView {
                List {
                    // Account Settings section
                    Section("Account") {
                        SettingsRow(icon: "person.circle", title: "Account Info", color: .blue)
                        SettingsRow(icon: "lock", title: "Privacy", color: .green)
                        SettingsRow(icon: "globe", title: "Language", color: .green)
                    }

                    // Support Section
                    Section("Support") {
                        SettingsRow(icon: "questionmark.circle", title: "Help", color: .orange)
                        SettingsRow(icon: "envelope", title: "Feedback", color: .blue)

                        // Logout Button
                        Button("Log Out") {
                            Task { // Use a Task for the asynchronous signOut operation
                                await authViewModel.signOut()
                                // Dismiss the settings sheet after successful logout
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                        .foregroundStyle(Color.red) // For modern SwiftUI, use foregroundStyle
                        .foregroundColor(.red) // Fallback for older iOS versions if needed
                    }
                }
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    // Done button to dismiss settings
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            presentationMode.wrappedValue.dismiss() // Dismiss the sheet
                        }
                    }
                }
            }
        }
    }
    
