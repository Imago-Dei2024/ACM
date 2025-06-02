//
//  HomeView.swift
//  ACM
//
//  Created by Connor Laber on 5/28/25.
//
import SwiftUI

struct HomeView: View {
    @State private var posts = samplePosts
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(posts) { post in
                        PostCardView(post: post)
                            .padding(.bottom, 8)
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "camera")
                            .font(.title2)
                    }
                }
                // Messages Button on the right
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Messages action would be implemented here
                    }) {
                        Image(systemName: "paperplane")
                            .font(.title2)
                    }
                }
            }
        }
    }
}
