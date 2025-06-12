//
//  SearchView.swift
//  ACM2
//
//  Created by Connor Laber on 6/12/25.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var selectedCategory = 0
    
    let categories = ["All", "Popular", "Recent", "Following"]
    
    var body: some View {
        NavigationView {
            VStack {
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    
                    TextField("Search...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding()
                
                // Category selector
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(0..<categories.count, id: \.self) { index in
                            Button(action: {
                                selectedCategory = index
                            }) {
                                Text(categories[index])
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(selectedCategory == index ? Color.blue : Color.gray.opacity(0.2))
                                    .foregroundColor(selectedCategory == index ? .white : .primary)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                // Discovery grid
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: 3), spacing: 2) {
                        ForEach(0..<12) { index in
                            let colors: [Color] = [.blue, .purple, .pink]
                            let randomColor = colors[index % colors.count]
                            
                            RoundedRectangle(cornerRadius: 8)
                                .fill(LinearGradient(colors: [randomColor.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .aspectRatio(1, contentMode: .fit)
                                .overlay(
                                    Image(systemName: ["photo", "video", "music.note"][index % 3])
                                        .font(.title)
                                        .foregroundColor(.white)
                                )
                        }
                    }
                    .padding()
                }
                
                Spacer()
            }
            .navigationTitle("Discover")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
