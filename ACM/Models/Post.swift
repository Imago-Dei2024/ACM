//
//  Post.swift
//  ACM
//
//  Created by Connor Laber on 6/2/25.
//

// Post model represents a social media post
import SwiftUI
import Foundation

struct Post: Identifiable {
    let id = UUID()
    let username: String
    let timeAgo: String
    let imageName: String // System icon name for placeholder
    let caption: String
    let likes: Int
}
 

// NotificationsItem model represents a user notification
struct NotificationItem: Identifiable {
    let id: UUID
    let icon: String // System icon name
    let title: String
    let message: String
    let timeAgo: String
    let isRead: Bool
    
    // Custom initializer to ensure id is set
    init(id: UUID = UUID(), icon: String, title: String,
         message: String, timeAgo: String, isRead: Bool) {
        self.id = id
        self.icon = icon
        self.title = title
        self.message = message
        self.timeAgo = timeAgo
        self.isRead = isRead 
    }
}
