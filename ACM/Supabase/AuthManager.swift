//
//  AuthManager.swift
//  ACM
//
//  Created by Connor Laber on 6/12/25.
//
//  Manages all authentication logic, including sign-in, sign-up, session status,
//  and user profile management with Supabase.
//

import Foundation
import Supabase
import Combine

// Make UserProfile conform to both Codable (Encodable & Decodable)
struct UserProfile: Codable, Identifiable {
    let id: UUID
    let fullName: String
    let email: String

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case email
    }
}

@MainActor // Run all functions in this class on the main thread
class AuthManager: ObservableObject {
    // MARK: - Published Properties
    @Published var session: Session?
    @Published var userProfile: UserProfile?
    @Published var isLoading = false
    @Published var errorMessage = ""

    private var authTask: Task<Void, Never>?

    // MARK: - Initializer
    init() {
        // Start a task to listen for authentication changes
        authTask = Task {
            for await authEvent in supabase.auth.authStateChanges {
                self.session = authEvent.session
                if authEvent.session != nil {
                    self.fetchUserProfile()
                } else {
                    self.userProfile = nil
                }
            }
        }
    }
    
    deinit {
        // Cancel the task when the AuthManager is no longer needed
        authTask?.cancel()
    }

    // MARK: - Public Methods

    func signIn(email: String, password: String) async {
        isLoading = true
        errorMessage = ""
        do {
            try await supabase.auth.signIn(email: email, password: password)
        } catch {
            self.errorMessage = "Failed to sign in: \(error.localizedDescription)"
            print("Login error: \(error)")
        }
        isLoading = false
    }

    func signUp(email: String, password: String, fullName: String) async {
        isLoading = true
        errorMessage = ""
        do {
            let authResponse = try await supabase.auth.signUp(email: email, password: password)
            let newUserProfile = UserProfile(id: authResponse.user.id, fullName: fullName, email: email)

            // 3. Insert the new profile into the 'profiles' table
            // **FIXED:** Removed `.database`
            try await supabase
                .from("profiles")
                .insert(newUserProfile)
                .execute()
            
            self.userProfile = newUserProfile

        } catch {
            self.errorMessage = "Failed to sign up: \(error.localizedDescription)"
            print("Signup error: \(error)")
        }
        isLoading = false
    }

    func fetchUserProfile() {
        guard let userId = session?.user.id else {
            errorMessage = "No active session to fetch profile."
            return
        }
        
        Task {
            do {
                // **FIXED:** Removed `.database`
                let profile: UserProfile = try await supabase
                    .from("profiles")
                    .select()
                    .eq("id", value: userId)
                    .single()
                    .execute()
                    .value
                
                self.userProfile = profile
            } catch {
                self.errorMessage = "Could not fetch user profile: \(error.localizedDescription)"
                print("Fetch Profile error: \(error)")
            }
        }
    }

    func signOut() async {
        isLoading = true
        do {
            try await supabase.auth.signOut()
        } catch {
            self.errorMessage = "Failed to sign out: \(error.localizedDescription)"
            print("Signout error: \(error)")
        }
        isLoading = false
    }
}
