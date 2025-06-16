//
//  AuthViewModel.swift
//  ACM
//
//  Created by Connor Laber on 6/15/25.
//

import Foundation
import Supabase
import Combine

/// `AuthViewModel` manages user authentication state and interactions with Supabase.
/// It publishes `isAuthenticated` to control view hierarchy, `userEmail` for display,
/// and `errorMessage` for user feedback.
@MainActor
class AuthViewModel: ObservableObject {
    /// `isAuthenticated` indicates if a user is currently logged in.
    @Published var isAuthenticated: Bool = false
    /// `userEmail` stores the email of the currently authenticated user.
    @Published var userEmail: String?
    /// `errorMessage` holds any error messages from authentication operations.
    @Published var errorMessage: String?

    /// `cancellables` stores Combine publishers to manage their lifetimes.
    private var cancellables = Set<AnyCancellable>()

    /// Initializes the `AuthViewModel`.
    /// Sets up a listener for real-time authentication state changes from Supabase.
    init() {
        // Listen for auth state changes from Supabase
        // This ensures our @Published properties are always in sync with Supabase's auth state.
        Task {
            await setupAuthListener()
        }
    }
    
    /// Sets up the authentication state listener
    private func setupAuthListener() async {
        for await (event, session) in supabase.auth.authStateChanges {
            await MainActor.run {
                if let session = session {
                    self.isAuthenticated = true
                    self.userEmail = session.user.email
                    self.errorMessage = nil // Clear any previous errors on successful auth
                    print("User authenticated: \(session.user.email ?? "Unknown")")
                } else {
                    self.isAuthenticated = false
                    self.userEmail = nil
                    print("User signed out")
                    // Do not clear errorMessage here if it was set by a failed signIn/signup attempt.
                }
            }
        }
    }

    /// Checks the current authentication session with Supabase.
    /// This is typically called when the app launches to determine the initial auth state.
    func checkAuthSession() async {
        do {
            let session = try await supabase.auth.session
            
            // Check if we have a valid session
            self.isAuthenticated = true
            self.userEmail = session.user.email
            self.errorMessage = nil
            print("Existing session found for: \(session.user.email ?? "Unknown")")
        } catch {
            // If there's an error (e.g., no active session), update state accordingly.
            self.isAuthenticated = false
            self.userEmail = nil
            print("No existing session: \(error.localizedDescription)")
        }
    }

    /// Handles user sign-up with email and password.
    /// - Parameters:
    ///   - email: The user's email address.
    ///   - password: The user's chosen password.
    func signUp(email: String, password: String) async {
        errorMessage = nil // Clear previous error before attempting new operation
        
        do {
            let response = try await supabase.auth.signUp(email: email, password: password)
            
            if let session = response.session {
                // User is immediately authenticated (email confirmation disabled)
                self.isAuthenticated = true
                self.userEmail = session.user.email
                print("Sign up successful, user authenticated: \(email)")
            } else {
                // Email confirmation required
                self.errorMessage = "Please check your email for a confirmation link before signing in."
                print("Sign up successful, email confirmation required: \(email)")
            }
        } catch {
            self.errorMessage = error.localizedDescription
            print("Sign up error: \(error)")
        }
    }

    /// Handles user sign-in with email and password.
    /// - Parameters:
    ///   - email: The user's email address.
    ///   - password: The user's password.
    func signIn(email: String, password: String) async {
        errorMessage = nil // Clear previous error before attempting new operation
        
        do {
            let session = try await supabase.auth.signIn(email: email, password: password)
            
            self.isAuthenticated = true
            self.userEmail = session.user.email
            print("Sign in successful: \(email)")
        } catch {
            self.errorMessage = error.localizedDescription
            print("Sign in error: \(error)")
        }
    }

    /// Handles user sign-out.
    func signOut() async {
        errorMessage = nil // Clear previous error before attempting new operation
        
        do {
            try await supabase.auth.signOut()
            self.isAuthenticated = false
            self.userEmail = nil
            print("Sign out successful")
        } catch {
            self.errorMessage = error.localizedDescription
            print("Sign out error: \(error)")
        }
    }
}
