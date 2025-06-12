//
//  ProfileView.swift
//  ACM2
//
//  Created by Connor Laber on 6/12/25.
//

import SwiftUI

struct ProfileView: View {
    @State private var showingSettings = false
    @State private var showingEditProfile = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Profile header section
                    VStack(spacing: 16) {
                        // Profile picture with gradient background
                        Circle()
                            .fill(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 100, height: 100)
                            .overlay(
                                Text("YN") // Your Name initials
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                            )
                        
                        // User information
                        VStack(spacing: 4) {
                            Text("Your Name")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("@your_username")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Text("🌟 Creating amazing interfaces with SwiftUI")
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        
                        // Statistics display
                        HStack(spacing: 30) {
                            StatView(number: "1.2K", label: "Posts")
                            StatView(number: "15.3K", label: "Followers")
                            StatView(number: "892", label: "Following")
                        }
                        
                        // Action buttons
                        HStack(spacing: 12) {
                            Button("Edit Profile") {
                                showingEditProfile = true
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            
                            Button("Share") {
                                // Profile sharing logic would be implemented here
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.2))
                            .foregroundColor(.primary)
                            .cornerRadius(20)
                        }
                    }
                    .padding()
                    
                    Divider()
                    
                    // Posts grid display
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: 3), spacing: 2) {
                        ForEach(0..<9) { index in
                            let colors: [Color] = [.blue, .purple, .pink]
                            let selectedColor = colors[index % colors.count]
                            
                            RoundedRectangle(cornerRadius: 8)
                                .fill(LinearGradient(colors: [selectedColor.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .aspectRatio(1, contentMode: .fit)
                                .overlay(
                                    Image(systemName: "photo")
                                        .font(.title)
                                        .foregroundColor(.white)
                                )
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Settings button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingSettings = true
                    }) {
                        Image(systemName: "gearshape")
                            .font(.title2)
                    }
                }
            }
        }
        // Settings sheet presentation
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
        // Edit profile sheet presentation
        .sheet(isPresented: $showingEditProfile) {
            EditProfileView()
        }
    }
}
