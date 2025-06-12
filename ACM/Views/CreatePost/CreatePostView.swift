//
//  CreatePostView.swift
//  ACM2
//
//  Created by Connor Laber on 6/12/25.
//

import SwiftUI

struct CreatePostView: View {
    // State variables for post creation and UI management
    @State private var postText = ""
    @State private var selectedImage = "photo"
    @State private var showingImagePicker = false
    @State private var showingLocationPicker = false
    @State private var showingTagPeople = false
    @State private var showingMusicPicker = false
    @State private var selectedLocation = ""
    @State private var taggedPeople: [String] = []
    @State private var selectedMusic = ""
    @State private var postPrivacy = "Public"
    @State private var allowComments = true
    @State private var allowSharing = true
    
    // Privacy options for the post
    let privacyOptions = ["Public", "Friends", "Only Me"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 24) {
                    // User profile header section
                    createProfileHeader()
                    
                    // Post content input section
                    createContentSection()
                    
                    // Media attachment section
                    createMediaSection()
                    
                    // Advanced options section
                    createAdvancedOptionsSection()
                    
                    // Privacy and sharing settings
                    createPrivacySection()
                    
                    // Additional features section
                    createAdditionalFeaturesSection()
                }
                .padding(.vertical)
            }
            .navigationTitle("Create Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Cancel button with confirmation
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        // Cancel logic with confirmation dialog would be implemented here
                    }
                    .foregroundColor(.secondary)
                }
                
                // Post button with validation
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") {
                        // Post validation and sharing logic would be implemented here
                    }
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
                    .disabled(postText.isEmpty)
                }
            }
            .background(Color(.systemGroupedBackground))
        }
    }
    
    // MARK: - Profile Header Component
    @ViewBuilder
    private func createProfileHeader() -> some View {
        HStack(spacing: 16) {
            // Enhanced user avatar with status indicator
            ZStack {
                Circle()
                    .fill(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Text("U")
                            .foregroundColor(.white)
                            .font(.title)
                            .fontWeight(.bold)
                    )
                
                // Online status indicator
                Circle()
                    .fill(Color.green)
                    .frame(width: 16, height: 16)
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 2)
                    )
                    .offset(x: 20, y: 20)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Your Name")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text("Share something with your friends")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // Privacy indicator
                HStack(spacing: 4) {
                    Image(systemName: privacyIcon(for: postPrivacy))
                        .font(.caption)
                        .foregroundColor(.blue)
                    
                    Text(postPrivacy)
                        .font(.caption)
                        .foregroundColor(.blue)
                        .fontWeight(.medium)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        .padding(.horizontal)
    }
    
    // MARK: - Content Input Section
    @ViewBuilder
    private func createContentSection() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("What's on your mind?")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.horizontal, 20)
            
            // Enhanced text editor with placeholder
            ZStack(alignment: .topLeading) {
                TextEditor(text: $postText)
                    .frame(minHeight: 150)
                    .padding(16)
                    .background(Color(.systemBackground))
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(postText.isEmpty ? Color.gray.opacity(0.3) : Color.blue.opacity(0.5), lineWidth: 1)
                    )
                
                // Placeholder text
                if postText.isEmpty {
                    Text("Share your thoughts, experiences, or anything you'd like to tell your friends...")
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 24)
                        .allowsHitTesting(false)
                }
            }
            .padding(.horizontal)
            
            // Character count indicator
            HStack {
                Spacer()
                Text("\(postText.count)/280")
                    .font(.caption)
                    .foregroundColor(postText.count > 280 ? .red : .secondary)
            }
            .padding(.horizontal, 20)
        }
    }
    
    // MARK: - Media Attachment Section
    @ViewBuilder
    private func createMediaSection() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Add Media")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.horizontal, 20)
            
            // Media selection grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
                // Photo/Video selector
                MediaOptionCard(
                    icon: "photo.on.rectangle",
                    title: "Photo/Video",
                    subtitle: "Add from gallery",
                    color: .blue,
                    action: { showingImagePicker = true }
                )
                
                // Camera selector
                MediaOptionCard(
                    icon: "camera",
                    title: "Camera",
                    subtitle: "Take a photo",
                    color: .green,
                    action: { /* Camera action */ }
                )
                
                // Live photo selector
                MediaOptionCard(
                    icon: "livephoto",
                    title: "Live Photo",
                    subtitle: "Capture moment",
                    color: .orange,
                    action: { /* Live photo action */ }
                )
                
                // GIF selector
                MediaOptionCard(
                    icon: "play.rectangle",
                    title: "GIF",
                    subtitle: "Add animation",
                    color: .purple,
                    action: { /* GIF action */ }
                )
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Advanced Options Section
    @ViewBuilder
    private func createAdvancedOptionsSection() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Enhance Your Post")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.horizontal, 20)
            
            VStack(spacing: 12) {
                // Location option
                AdvancedOptionRow(
                    icon: "location",
                    title: "Add Location",
                    subtitle: selectedLocation.isEmpty ? "Where are you?" : selectedLocation,
                    color: .red,
                    isSelected: !selectedLocation.isEmpty,
                    action: { showingLocationPicker = true }
                )
                
                // Tag people option
                AdvancedOptionRow(
                    icon: "person.2",
                    title: "Tag People",
                    subtitle: taggedPeople.isEmpty ? "Who are you with?" : "\(taggedPeople.count) people tagged",
                    color: .blue,
                    isSelected: !taggedPeople.isEmpty,
                    action: { showingTagPeople = true }
                )
                
                // Music option
                AdvancedOptionRow(
                    icon: "music.note",
                    title: "Add Music",
                    subtitle: selectedMusic.isEmpty ? "What are you listening to?" : selectedMusic,
                    color: .green,
                    isSelected: !selectedMusic.isEmpty,
                    action: { showingMusicPicker = true }
                )
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Privacy Settings Section
    @ViewBuilder
    private func createPrivacySection() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Privacy & Sharing")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.horizontal, 20)
            
            VStack(spacing: 16) {
                // Privacy selector
                HStack {
                    Image(systemName: privacyIcon(for: postPrivacy))
                        .font(.title2)
                        .foregroundColor(.blue)
                        .frame(width: 30)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Who can see this post?")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        Picker("Privacy", selection: $postPrivacy) {
                            ForEach(privacyOptions, id: \.self) { option in
                                Text(option).tag(option)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                Divider()
                
                // Comment settings
                HStack {
                    Image(systemName: "bubble.left")
                        .font(.title2)
                        .foregroundColor(.green)
                        .frame(width: 30)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Allow Comments")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        Text("People can comment on your post")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Toggle("", isOn: $allowComments)
                        .labelsHidden()
                }
                
                // Sharing settings
                HStack {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title2)
                        .foregroundColor(.purple)
                        .frame(width: 30)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Allow Sharing")
                            .font(.subheadline)
                            .fontWeight(.medium)
                        
                        Text("People can share your post")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Toggle("", isOn: $allowSharing)
                        .labelsHidden()
                }
            }
            .padding(20)
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
            .padding(.horizontal)
        }
    }
    
    // MARK: - Additional Features Section
    @ViewBuilder
    private func createAdditionalFeaturesSection() -> some View {
        VStack(spacing: 20) {
            // Quick actions
            HStack(spacing: 20) {
                QuickActionButton(
                    icon: "clock",
                    title: "Schedule",
                    color: .orange,
                    action: { /* Schedule action */ }
                )
                
                QuickActionButton(
                    icon: "bookmark",
                    title: "Save Draft",
                    color: .blue,
                    action: { /* Save draft action */ }
                )
                
                QuickActionButton(
                    icon: "eye",
                    title: "Preview",
                    color: .green,
                    action: { /* Preview action */ }
                )
            }
            .padding(.horizontal)
            
            // Enhanced share button
            Button(action: {
                // Advanced post sharing logic would be implemented here
            }) {
                HStack(spacing: 12) {
                    Image(systemName: "paperplane.fill")
                        .font(.headline)
                    
                    Text("Share Post")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(
                    LinearGradient(
                        colors: postText.isEmpty ? [.gray.opacity(0.5)] : [.blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .cornerRadius(16)
                .shadow(color: .blue.opacity(0.3), radius: 8, x: 0, y: 4)
            }
            .disabled(postText.isEmpty)
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
    }
    
    // MARK: - Helper Functions
    private func privacyIcon(for privacy: String) -> String {
        switch privacy {
        case "Public": return "globe"
        case "Friends": return "person.2"
        case "Only Me": return "lock"
        default: return "globe"
        }
    }
}
