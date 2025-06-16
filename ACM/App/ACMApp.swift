//
//  ACMApp.swift
//  ACM
//
//  Created by Connor Laber on 6/12/25.
//

//
//  ACMApp.swift
//  ACM
//
//  Created by Connor Laber on 6/12/25.
//

// ACMApp.swift
import SwiftUI
import Supabase // 1. Import Supabase

// 2. Initialize Supabase client
let supabase = SupabaseClient(
    supabaseURL: URL(string: "https://qmfxylsrkgdgrtmzdjjw.supabase.co")!, // REPLACE WITH YOUR SUPABASE URL
    supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFtZnh5bHNya2dkZ3J0bXpkamp3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAwNTAyOTMsImV4cCI6MjA2NTYyNjI5M30.Tmfi0PRVoWW_XMMeOILdbqJWQTJh9JhmLvuemMr92_k" // REPLACE WITH YOUR SUPABASE ANON KEY
)

@main
struct ACMApp: App {
    // Create an instance of AuthViewModel to be shared across the app
    @StateObject var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            RootView() // Now starts with RootView
                .environmentObject(authViewModel) // Inject AuthViewModel into the environment
        }
    }
}
