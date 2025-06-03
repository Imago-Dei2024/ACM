//
//  NotificationsView.swift
//  ACM
//
//  Created by Connor Laber on 6/2/25.
//

// NotificationsView displays user notifications in a list

import SwiftUI

struct NotificationsView: View {
    // State array containing sample notifications
    @State private var notifications = sampleNotifications
    
    var body: some View {
        NavigationView {
            List {
                // Display each notification as a row
                ForEach(notifications) { notification in
                    NotificationRow(notification: notification)
                }
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // Mark all a read button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Mark All Read") {
                        // Mark all notifications as read logic
                        for index in notifications.indices {
                            notifications[index] = NotificationItem(
                                id: notifications[index].id,
                                icon: notifications[index].icon,
                                title: notifications[index].title,
                                message: notifications[index].message,
                                timeAgo: notifications[index].timeAgo,
                                isRead: true
                            )
                        }
                    }
                    .font(.caption)
                }
            }
        }
    }
}
