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
                    Button("Change Picture ")
                }
            }
        }
    }
}
