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
        /// It immediately checks the current authentication session and sets up a listener
        /// for real-time authentication state changes from Supabase.
        init() {
            // Check current session on app launch
            Task {
                await checkAuthSession()
            }

            // Listen for auth state changes from Supabase
            // This ensures our @Published properties are always in sync with Supabase's auth state.
            supabase.auth.onAuthStateChange { [weak self] event, session in
                DispatchQueue.main.async {
                    if let session = session {
                        self?.isAuthenticated = true
                        self?.userEmail = session.user.email
                        self?.errorMessage = nil // Clear any previous errors on successful auth
                    } else {
                        self?.isAuthenticated = false
                        self?.userEmail = nil
                        // Do not clear errorMessage here if it was set by a failed signIn/signUp attempt
                    }
                }
            }
        }

        /// Checks the current authentication session with Supabase.
        /// This is typically called when the app launches to determine the initial auth state.
        @MainActor
        func checkAuthSession() async {
            do {
                // Attempt to get the current session.
                // The onAuthStateChange listener will handle updating isAuthenticated and userEmail.
                _ = try await supabase.auth.session
            } catch {
                // If there's an error (e.g., no active session), update state accordingly.
                isAuthenticated = false
                userEmail = nil
                errorMessage = error.localizedDescription
            }
        }

        /// Handles user sign-up with email and password.
        /// @MainActor ensures this function runs on the main thread, important for UI updates.
        /// - Parameters:
        ///   - email: The user's email address.
        ///   - password: The user's chosen password.
        @MainActor
        func signUp(email: String, password: String) async {
            errorMessage = nil // Clear previous error
            do {
                _ = try await supabase.auth.signUp(email: email, password: password)
                // The onAuthStateChange listener will automatically update isAuthenticated and userEmail upon successful sign-up.
                // Supabase typically sends a confirmation email, and the user won't be fully authenticated until confirmed.
            } catch {
                errorMessage = error.localizedDescription // Set error message on failure
            }
        }

        /// Handles user sign-in with email and password.
        /// @MainActor ensures this function runs on the main thread.
        /// - Parameters:
        ///   - email: The user's email address.
        ///   - password: The user's password.
        @MainActor
        func signIn(email: String, password: String) async {
            errorMessage = nil // Clear previous error
            do {
                _ = try await supabase.auth.signIn(email: email, password: password)
                // The onAuthStateChange listener will automatically update isAuthenticated and userEmail upon successful sign-in.
            } catch {
                errorMessage = error.localizedDescription // Set error message on failure
            }
        }

        /// Handles user sign-out.
        /// @MainActor ensures this function runs on the main thread.
        @MainActor
        func signOut() async {
            errorMessage = nil // Clear previous error
            do {
                try await supabase.auth.signOut()
                // The onAuthStateChange listener will automatically update isAuthenticated and userEmail.
            } catch {
                errorMessage = error.localizedDescription // Set error message on failure
            }
        }
    }
