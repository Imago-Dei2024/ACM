//
//  EditProfileView.swift
//  ACM
//
//  Created by Connor Laber on 6/2/25.
//

// EditProfileView allows users to modify their profile information

import SwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    // State variables for editable profile fields
    @State private var name = "Your Name"
    @State private var username = "your_username"
    @State private var bio = "🌟 Creating amazing interfaces with SwiftUI"
    
    var body: some View {
        NavigationView {
            Form {
                //Profile picture section
                Section("Profile Picture") {
                    HStack {
                        Spacer()
                        // Current profile picture display
                        Circle()
                            .fill(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 80, height: 80)
                            .overlay(
                                Text("YN")
                                    .foregroundColor(.white)
                                    .font(.title)
                                    .fontWeight(.bold)
                            )
                        Spacer()
                    }
                    
                    // Change picture button
                    Button("Change Picture") {
                        // Picture change logic would be implemented here
                    }
                    .frame(maxWidth: .infinity)
                }
                
                // Personal Information Section
                Section("Personal Information") {
                    HStack {
                        Text("Name")
                        Spacer()
                        TextField("Username", text: $name)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Username")
                        Spacer()
                        TextField("Username", text: $username)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                // Bio Section
                Section(content: "About")
                TextEditor(text: $bio)
                    .frame(minHeight: 60)
            }
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            //Cancel Button
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            
            // Save Button
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    // Save logic would be implemented here
                    presentationMode.wrappedValue.dismiss()
                }
                .fontWeight(.semibold) 
            }
        }
    }
}
