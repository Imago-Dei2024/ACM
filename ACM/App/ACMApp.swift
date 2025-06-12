//
//  ACMApp.swift
//  ACM
//
//  Created by Connor Laber on 6/12/25.
//
//  The main entry point of the app. It uses the AuthManager to decide
//  which view to show based on the user's authentication state.
//

import SwiftUI

@main
struct ACMApp: App {
    // Create and manage the lifecycle of the AuthManager.
    @StateObject private var authManager = AuthManager()

    var body: some Scene {
        WindowGroup {
            // Conditionally show ContentView or AuthenticationView.
            Group {
                if authManager.session != nil {
                    // If a session exists, the user is logged in.
                    ContentView()
                } else {
                    // If there's no session, show the login/signup screen.
                    AuthenticationView()
                }
            }
            // Provide the AuthManager to the entire view hierarchy.
            .environmentObject(authManager)
        }
    }
}
