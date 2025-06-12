//
//  EditProfileView.swift
//  ACM2
//
//  Created by Connor Laber on 6/12/25.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name = "Your Name"
    @State private var username = "your_username"
    @State private var bio = "🌟 Creating amazing interfaces with SwiftUI"
    
    var body: some View {
        NavigationView {
            Form {
                // Profile picture section
                Section("Profile Picture") {
                    HStack {
                        Spacer()
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
                    
                    Button("Change Picture") {
                        // Picture change logic would be implemented here
                    }
                    .frame(maxWidth: .infinity)
                }
                
                // Personal information section
                Section("Personal Information") {
                    HStack {
                        Text("Name")
                        Spacer()
                        TextField("Name", text: $name)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Username")
                        Spacer()
                        TextField("Username", text: $username)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                // Bio section
                Section("About") {
                    TextEditor(text: $bio)
                        .frame(minHeight: 60)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
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
}
