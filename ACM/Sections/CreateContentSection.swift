//
//  CreateContentSection.swift
//  ACM
//
//  Created by Connor Laber on 6/2/25.
//

import SwiftUI

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
                        .stroke(postText.isEmpty ? Color.gray.opacity(0.3) :
                            Color.blue.opacity(0.5), lineWidth: 1)
                )
            
            // Placeholder text
            if postText.isEmpty {
                Text("Share your thoughts, experiences, or anything you'd like to tel your freinds...")
                    .foregroundStyle(.secondary)
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
                .foregroundStyle(postText.count > 280 ? .red : .secondary)
        }
        .padding(.horizontal, 20) 
    }
}
