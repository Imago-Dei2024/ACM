//
//  ACMApp.swift
//  ACM
//
//  Created by Connor Laber on 6/12/25.
//

import SwiftUI
import Supabase

// Initialize Supabase client using secure configuration
let supabase = SupabaseClient(
    supabaseURL: URL(string: ConfigManager.shared.supabaseURL)!,
    supabaseKey: ConfigManager.shared.supabaseAnonKey
)

@main
struct ACMApp: App {
    // Create an instance of AuthViewModel to be shared across the app
    @StateObject var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            RootView() // Now starts with RootView
                .environmentObject(authViewModel) // Inject AuthViewModel into the environment
                .onAppear {
                    // Validate configuration on app launch
                    ConfigManager.shared.validateConfiguration()
                }
        }
    }
}
