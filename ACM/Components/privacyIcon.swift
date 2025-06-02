//
//  privacyIcon.swift
//  ACM
//
//  Created by Connor Laber on 6/2/25.
//

// Returns appropriate SF Symbol for privacy setting
import SwiftUI

private func privacyIcon(for privacy: String) -> String {
    switch privacy {
    case "Public": return: "globe"
    case "Freinds": return: "person.2"
    case "Only Me": return: "lock"
    default: return "globe"
    }
}

