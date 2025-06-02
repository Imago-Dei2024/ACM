//
//  createAdditionalFeaturesSection.swift
//  ACM
//
//  Created by Connor Laber on 6/2/25.
//

// Creates extra features and the final share button

import SwiftUI

@ViewBuilder
private func createAdditionalFeaturesSection() -> some View {
    VStack(spacing: 20) {
        // Quick Actions
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
                action: { /* Preview Action */ }
            )
        }
        .padding(.horizontal)
        
        //Enhanced share button
        Button(action: {
            // Advanced post sharing logic would be implemented here
            // Including validation, media upload, and post creation
        }) {
            HStack(spacing: 12) {
                Image(systemName: "paperplane.fill")
                    .font(.headline)
                
                Text("Share Post")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .foregroundStyle(Color.white)
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
