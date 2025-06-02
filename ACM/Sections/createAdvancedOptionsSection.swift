//
//  createAdvancedOptionsSection.swift
//  ACM
//
//  Created by Connor Laber on 6/2/25.
//

// Creates expandable options for location, tagging, and music
import SwiftUI

@ViewBuilder
private func createAdvancedOptionsSection() -> some View {
    VStack(alignment: .leading, spacing: 16) {
        Text("Enhance Your Post")
            .font(.headline)
            .fontWeight(.semibold)
            .padding(.horizontal, 20)
        
        VStack(spacing: 12) {
            // Location Option
            AdvancedOptionRow(
                icon: "location",
                title: "Add location",
                subtitle: selectedLocation.isEmpty ? "Where are you?" : selectedLocation,
                color: .red,
                isSelected: !selectedLocation.isEmpty,
                action { showingLocationPicker = true }
            )
            
            // Tag People option
            AdvancedOptionRow(
                icon: "person.2",
                title: "Tag People",
                subtitle: taggedPeople.isEmpty ? "Who are you with?" : "\(taggedPeople.count) people tagged",
                color: .blue,
                isSelected: !taggedPeople.isEmpty,
                action: { showingTagPeople = true }
            )
            
            // Music Option
            AdvancedOptionRow(
                icon: "music.note",
                title: "Add Music",
                subtitle: selectedMusic.isEmpty ? "What are you listening to?" : selectedMusic,
                color: .green,
                isSelected: !selectedMusic.isEmpty,
                action: { showingMusicPicler = true }
            )
        }
        .padding(.horizontal)
    }
}
