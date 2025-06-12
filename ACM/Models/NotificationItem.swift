//
//  NotificationItem.swift
//  ACM2
//
//  Created by Connor Laber on 6/12/25.
//
import Foundation

struct NotificationItem: Identifiable {
    let id: UUID
    let icon: String // System icon name
    let title: String
    let message: String
    let timeAgo: String
    let isRead: Bool
    
    init(id: UUID = UUID(), icon: String, title: String, message: String, timeAgo: String, isRead: Bool) {
        self.id = id
        self.icon = icon
        self.title = title
        self.message = message
        self.timeAgo = timeAgo
        self.isRead = isRead
    }
}
