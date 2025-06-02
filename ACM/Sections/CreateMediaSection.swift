//
//  CreateMediaSection.swift
//  ACM
//
//  Created by Connor Laber on 6/2/25.
//

import SwiftUI

@ViewBuilder
private func createMediaSection() -> some View {
    VStack(alignment: .leading, spacing: 16) {
        Text("Add Media")
            .font(.headline)
            .fontWeight(.semibold)
            .padding(.horizontal, 20)
        
        // Media section grid
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), soacing: 12), count:2), spacing: 12) {
            // Photo/Video Selector
            MediaOptionCard(
                icon:  "photo.on.rectangle",
                title: "Photo/Video",
                subtitle: "Add from gallery",
                color: .blue,
                action: { showingImagePicker = true }
            )
            
            // Camera Selector
            MediaOptionCard(
                icon: "camera",
                title: "Camera",
                subtitle: "Take a photo",
                color: .green,
                action: { /* Camera Action */ }
            )
            
            // Live photo selector
            MediaOptionCard(
                icone: "livephoto",
                title: "Live Photo",
                subtitle: "Capture Moment",
                color: .orange,
                action: { /* Live photo action */ }
            )
            
            // Gif Selector
            MediaOptionCard(
                icon: "play.rectangle",
                title: "GIF",
                subtitle: "Add animation",
                color: .purple,
                action: { /* GIF Action */ }
            )
        }
        .padding(.horizontal) 
    }
}
