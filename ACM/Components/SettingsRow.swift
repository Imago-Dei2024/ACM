//
//  SettingsRow.swift
//  ACM
//
//  Created by Connor Laber on 6/2/25.
//

// SettingsRow displays individual setting options

import SwiftUI

struct SettingsRow: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        HStack {
            // Settng icon
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
                .frame(width: 30)
            
            // Setting title
            Text(title)
                .font(.body)
            
            Spacer()
            
            // Navigation chevron
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.secondary) 
        }
    }
}
