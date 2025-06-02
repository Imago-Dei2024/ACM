//
//  PostCardView.swift
//  ACM
//
//  Created by Connor Laber on 5/28/25.
//

import SwiftUI

struct PostCardView: View {
    let post: Post
    //State variables for interactive elements
    @State private var isLiked = false
    @State private var likeCount = Int
    
    //Custom initializer to set initial like count
    init(post: Post) {
        self.post = post
        self._likeCount = State(initialValue: post.likes)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            //User information header
            HStack {
                //User avatar with gradient background
                Circle()
                    .fill(linearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width:40, height: 40)
                    .overlay(
                        // Display first letter of username as avatar
                        Text(String(post.username.prefix(1)).uppercased())
                            .foregroundColor(.white)
                            .font(.headline)
                    )
                //Username and timestamp
                VStack(alignment: .leading, spacing: 2) {
                    Text(post.username)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text(post.timeAgo)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                
                // More options button
                Button(action: {
                    //More options action would be implemented here
                }) {
                    Image(systemName: "ellipsis")
                        .font(.title2)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal)
            
            // Post image placeholder with gradient background
            RoundedRectangle(cornerRadius: 12)
                .fill(linearGradient(colors: [Color.blue.opacity(0.3),
                                              Color.purple.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(height: 300)
                .overlay(
                    //System icon as placeholder
                    Image(systemName: post.imageName)
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                )
                .padding(.horizontal)
            
            // Interaction buttons (like, comment, share, bookmark)
            HStack(spacing: 16) {
                // Like button with state management
                Button(action: {
                    withAnimation(.spring()) {
                        isLike.toggle()
                        likeCount += isLiked ? 1 : -1
                    }
                }) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .font(.title2)
                        .foregroundColor(isLiked ? .red : .primary)
                }
                
                // Comment Button
                Button(action: {
                    //Comment action would be implemented here
                }) {
                    Image(systemName: "message")
                        .font(.title2)
                }
                
                // Share Button
                Button(action: {
                    //Share action would be implemented here
                }) {
                    Image(systemName: "paperplane")
                        .font(.title2)
                }
                
                Spacer()
                
                //Bookmark Button
                Button(action: {
                    // Bookmark action would be implemented here
                }) {
                    Image(systemName: "bookmark")
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            
            // Like count display
            Text("\(likeCount) likes")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.horizontal)
            
            //Post caption text
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
