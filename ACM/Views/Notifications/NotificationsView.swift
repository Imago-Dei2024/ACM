//
//  NotificationsView.swift
//  ACM2
//
//  Created by Connor Laber on 6/12/25.
//

import SwiftUI

struct NotificationsView: View {
    @State private var notifications = sampleNotifications
    
    var body: some View {
        NavigationView {
            List {
                ForEach(notifications) { notification in
                    NotificationRow(notification: notification)
                }
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
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
