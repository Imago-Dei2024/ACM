//
//  Post.swift
//  ACM2
//
//  Created by Connor Laber on 6/12/25.
//

import Foundation

struct Post: Identifiable {
    let id = UUID()
    let username: String
    let timeAgo: String
    let imageName: String // System icon name for placeholder
    let caption: String
    let likes: Int
}
