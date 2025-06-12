//
//  PostCardView.swift
//  ACM2
//
//  Created by Connor Laber on 6/12/25.
//

import SwiftUI

struct PostCardView: View {
    let post: Post
    @State private var isLiked = false
    @State private var likeCount: Int
    
    init(post: Post) {
        self.post = post
        self._likeCount = State(initialValue: post.likes)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // User information header
            HStack {
                Circle()
                    .fill(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text(String(post.username.prefix(1)).uppercased())
                            .foregroundColor(.white)
                            .font(.headline)
                    )
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(post.username)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text(post.timeAgo)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button(action: {
                    // More options action would be implemented here
                }) {
                    Image(systemName: "ellipsis")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal)
            
            // Post image placeholder
            RoundedRectangle(cornerRadius: 12)
                .fill(LinearGradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(height: 300)
                .overlay(
                    Image(systemName: post.imageName)
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                )
                .padding(.horizontal)
            
            // Interaction buttons
            HStack(spacing: 16) {
                Button(action: {
                    withAnimation(.spring()) {
                        isLiked.toggle()
                        likeCount += isLiked ? 1 : -1
                    }
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .font(.title2)
                        .foregroundColor(isLiked ? .red : .primary)
                }
                
                Button(action: {}) {
                    Image(systemName: "message")
                        .font(.title2)
                }
                
                Button(action: {}) {
                    Image(systemName: "paperplane")
                        .font(.title2)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "bookmark")
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            
            Text("\(likeCount) likes")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            Text(post.caption)
                .font(.body)
                .padding(.horizontal)
        }
        .padding(.vertical, 15)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        .padding(.horizontal)
    }
}
