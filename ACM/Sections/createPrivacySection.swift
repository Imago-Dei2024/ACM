//
//  createPrivacySection.swift
//  ACM
//
//  Created by Connor Laber on 6/2/25.
//

// Creates privacy and sharing controls
import SwiftUI

@ViewBuilder
private func createPrivacySection() -> some View {
    VStack(alignment: .leading, spacing: 16) {
        Text("Privacy & Sharing")
            .font(.headline)
            .fontWeight(.semibold)
            .padding(.horizontal, 20)
        
        VStack(spacing: 16) {
            //Privacy selector
            HStack {
                Image(systemName: privacyIcon(for: postPrivacy))
                    .font(.title2)
                    .foregroundStyle(Color.blue)
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
            .Divider()
            
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
                        .foregroundStyle(.secondary)
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
