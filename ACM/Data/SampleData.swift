//
//  SampleData.swift
//  ACM
//
//  Created by Connor Laber on 6/15/25.
//

import Foundation

let samplePosts = [
    Post(username: "designerpro", timeAgo: "2 hours ago", imageName: "paintbrush.pointed", caption: "Do you like my new design? This interface made with SwiftUI is really amazing! 🎨✨", likes: 124),
    Post(username: "codingmaster", timeAgo: "5 hours ago", imageName: "laptopcomputer", caption: "Today I developed an incredible app with SwiftUI. Coding can be this fun! 💻", likes: 89),
    Post(username: "photoart", timeAgo: "8 hours ago", imageName: "camera", caption: "The fascinating world of nature photography. This landscape is truly breathtaking! 📸🌄", likes: 256),
    Post(username: "musiclover", timeAgo: "1 day ago", imageName: "music.note", caption: "The universal language of music unites everyone. What song are you listening to today? 🎵", likes: 67)
]

// Sample notifications for demonstration purposes
let sampleNotifications = [
    NotificationItem(icon: "heart.fill", title: "New Like", message: "designerpro liked your post", timeAgo: "5 min ago", isRead: false),
    NotificationItem(icon: "message", title: "New Comment", message: "codingmaster: \"Great post!\"", timeAgo: "15 min ago", isRead: false),
    NotificationItem(icon: "person.badge.plus", title: "New Follower", message: "photoart started following you", timeAgo: "1 hour ago", isRead: true),
    NotificationItem(icon: "star", title: "Featured Post", message: "Your post was featured", timeAgo: "3 hours ago", isRead: true),
    NotificationItem(icon: "bell", title: "Reminder", message: "Your friends are waiting for you", timeAgo: "1 day ago", isRead: true)
]
