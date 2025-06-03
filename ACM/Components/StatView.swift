//
//  StatView.swift
//  ACM
//
//  Created by Connor Laber on 6/2/25.
//

// StatView displays numerical statistics with labels.
import SwiftUI

struct StatView: View {
    let number: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            // Statistical Number
            Text(number)
                .font(.headline)
                .fontWeight(.bold)
            
            // Statistics Label
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary) 
        }
    }
}
