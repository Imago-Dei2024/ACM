//
//  ProfileHeader.swift
//  ACM
//
//  Created by Connor Laber on 6/2/25.
//

import SwiftUI

@ViewBuilder
private func createProfileHeader() -> some View {
    HStack(spacing: 16) {
        // Enhanced user avatar with status indicator
        ZStack{
            Circle()
                .fill(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 60, height: 60)
                .overlay(
                    Text("U")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)
                )
            
            // Online Status Indicator
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
            
            Text("Share something with your freinds")
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            // Privacy Indicator
            HStack(spacing: 4) {
                Image(systemName: privacyIcon(for: postPrivacy))
                    .font(.caption)
                    .foregroundStyle(Color.blue)
                
                Text(postPrivacy)
                    .font(.caption)
                    .foregroundStyle(Color.blue)
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
}
