//
//  NotificationRow.swift
//  ACM
//
//  Created by Connor Laber on 6/2/25.
//

//NotificationRow displays individual notification information

import SwiftUI

struct NotificationRow: View {
    let notification: NotificationItem 
    
    var body: some View {
        HStack(spacing: 12) {
            // Notification icon with conditional styling based on read status
            Circle()
                .fill(notification.isRead ?
                      AnyShapeStyle(Color.gray.opacity(0.3)) :
                        AnyShapeStyle(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: notification.icon)
                        .foregroundColor(.white)
                        .font(.headline)
                )
            
            // Notification content
            VStack(alignment: .leading, spacing: 4) {
                Text(notification.title)
                    .font(.subheadline)
                    .fontWeight(.notification.isRead ? .regular : .semibold)
                
                Text(notification.message)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                
                Text(notification.timeAgo)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            // Unread indicator dot
            
            if !notification.isRead {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.vertical, 4)
    }
}
