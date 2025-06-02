//
//  CreatePostView.swift
//  ACM
//
//  Created by Connor Laber on 6/2/25.
//

import SwiftUI


struct CreatePostView: View {
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
    let privacyOptions = ["Public", "Freinds", "Only Me"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 24) {
                    //User profile header section
                    createProfileHeader()
                    
                    // Post content input section
                    createContentSection()
                    
                    // Media attachment section
                    createMediaSection()
                    
                    // Advanced options section
                    createAdvancedOptionsSection()
                    
                    // Privacy and sharing settings
                    createPrivacySection()
                    
                    // Additional Features section
                    createAdditionalFeaturesSection()
                }
                .padding(.vertical)
            }
            .navigationTitle("Create Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Cancel button w confirmation
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        // Cancel logic with confirmation dialog would be implemented here
                    }
                    .foregroundColor(.secondary)
                }
                // Post button with validation
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Post") {
                        //Post validation and sharing logic would be implemented here
                    }
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
                    .disabled(postText.isEmpty)
                }
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}
