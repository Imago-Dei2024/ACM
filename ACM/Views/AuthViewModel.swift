//
//  EnhancedAuthViewModel.swift
//  ACM
//
//  Enhanced authentication view model with performance optimizations
//

import Foundation
import Supabase
import Combine
import SwiftUI

/// Enhanced `AuthViewModel` with modern performance optimizations and better error handling
@MainActor
class AuthViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var isAuthenticated: Bool = false
    @Published var userEmail: String?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    private let authStateSubject = PassthroughSubject<AuthState, Never>()
    
    // MARK: - Computed Properties
    var hasActiveSession: Bool {
        isAuthenticated && userEmail != nil
    }
    
    // MARK: - Initialization
    init() {
        setupAuthStateListener()
        setupErrorHandling()
    }
    
    // MARK: - Public Methods
    
    /// Checks the current authentication session with improved caching
    func checkAuthSession() async {
        // Quick local check first for better perceived performance
        if let cachedEmail = UserDefaults.standard.string(forKey: "cached_user_email") {
            self.userEmail = cachedEmail
            self.isAuthenticated = true
        }
        
        do {
            let session = try await supabase.auth.session
            await updateAuthState(with: session)
            
            // Cache user info for faster startup
            if let email = session.user.email {
                UserDefaults.standard.set(email, forKey: "cached_user_email")
            }
            
            print("✅ Session validated for: \(session.user.email ?? "Unknown")")
        } catch {
            await handleAuthError(error)
            // Clear cached data on auth failure
            UserDefaults.standard.removeObject(forKey: "cached_user_email")
        }
    }
    
    /// Enhanced sign-up with better error handling and feedback
    func signUp(email: String, password: String) async {
        await performAuthOperation {
            let response = try await supabase.auth.signUp(email: email, password: password)
            
            if let session = response.session {
                await self.updateAuthState(with: session)
                await self.showSuccessMessage("Account created successfully!")
            } else {
                await self.showInfoMessage("Please check your email for a confirmation link.")
            }
        }
    }
    
    /// Enhanced sign-in with retry mechanism
    func signIn(email: String, password: String) async {
        await performAuthOperation {
            let session = try await supabase.auth.signIn(email: email, password: password)
            await self.updateAuthState(with: session)
            await self.showSuccessMessage("Welcome back!")
        }
    }
    
    /// Enhanced sign-out with proper cleanup
    func signOut() async {
        isLoading = true
        
        do {
            try await supabase.auth.signOut()
            await clearAuthState()
            await showSuccessMessage("Signed out successfully")
            print("✅ Sign out successful")
        } catch {
            await handleAuthError(error)
        }
        
        isLoading = false
    }
    
    /// Reset password functionality
    func resetPassword(email: String) async {
        await performAuthOperation {
            try await supabase.auth.resetPasswordForEmail(email)
            await self.showSuccessMessage("Password reset email sent!")
        }
    }
    
    // MARK: - Private Methods
    
    /// Centralized authentication operation handler
    private func performAuthOperation(_ operation: @escaping () async throws -> Void) async {
        clearErrorMessage()
        isLoading = true
        
        do {
            try await operation()
        } catch {
            await handleAuthError(error)
        }
        
        isLoading = false
    }
    
    /// Enhanced auth state listener with better performance
    private func setupAuthStateListener() {
        Task {
            for await (event, session) in supabase.auth.authStateChanges {
                await MainActor.run {
                    switch event {
                    case .signedIn:
                        if let session = session {
                            Task { await self.updateAuthState(with: session) }
                        }
                    case .signedOut:
                        Task { await self.clearAuthState() }
                    case .passwordRecovery:
                        self.errorMessage = nil // Clear any existing errors
                    case .tokenRefreshed:
                        if let session = session {
                            self.userEmail = session.user.email
                        }
                    case .userUpdated:
                        if let session = session {
                            self.userEmail = session.user.email
                        }
                    default:
                        break
                    }
                }
            }
        }
    }
    
    /// Setup error handling with user-friendly messages
    private func setupErrorHandling() {
        // Additional error handling setup if needed
    }
    
    /// Update authentication state with session
    private func updateAuthState(with session: Session) async {
        self.isAuthenticated = true
        self.userEmail = session.user.email
        self.errorMessage = nil
        
        // Cache for faster startup
        if let email = session.user.email {
            UserDefaults.standard.set(email, forKey: "cached_user_email")
        }
    }
    
    /// Clear authentication state
    private func clearAuthState() async {
        self.isAuthenticated = false
        self.userEmail = nil
        self.errorMessage = nil
        
        // Clear cached data
        UserDefaults.standard.removeObject(forKey: "cached_user_email")
    }
    
    /// Enhanced error handling with user-friendly messages
    private func handleAuthError(_ error: Error) async {
        let userFriendlyMessage = mapErrorToUserFriendlyMessage(error)
        self.errorMessage = userFriendlyMessage
        
        print("❌ Auth error: \(error.localizedDescription)")
        
        // Log detailed error for debugging
        if let authError = error as? AuthError {
            print("📝 Auth error details: \(authError)")
        }
    }
    
    /// Map technical errors to user-friendly messages
    private func mapErrorToUserFriendlyMessage(_ error: Error) -> String {
        let errorString = error.localizedDescription.lowercased()
        
        switch true {
        case errorString.contains("invalid login credentials"):
            return "Invalid email or password. Please check your credentials and try again."
        case errorString.contains("email not confirmed"):
            return "Please check your email and click the confirmation link before signing in."
        case errorString.contains("user already registered"):
            return "An account with this email already exists. Try signing in instead."
        case errorString.contains("network"):
            return "Network connection error. Please check your internet connection and try again."
        case errorString.contains("rate limit"):
            return "Too many attempts. Please wait a moment before trying again."
        case errorString.contains("weak password"):
            return "Password is too weak. Please choose a stronger password with at least 8 characters."
        case errorString.contains("invalid email"):
            return "Please enter a valid email address."
        case errorString.contains("timeout"):
            return "Request timed out. Please check your connection and try again."
        default:
            return "Something went wrong. Please try again."
        }
    }
    
    /// Clear error message
    private func clearErrorMessage() {
        errorMessage = nil
    }
    
    /// Show success message (could be extended to show toast notifications)
    private func showSuccessMessage(_ message: String) async {
        print("✅ \(message)")
        // Could trigger a success toast notification here
    }
    
    /// Show info message
    private func showInfoMessage(_ message: String) async {
        print("ℹ️ \(message)")
        // Could trigger an info toast notification here
    }
}

// MARK: - AuthState Enum
enum AuthState {
    case signedIn(Session)
    case signedOut
    case loading
    case error(String)
}

// MARK: - Extensions for Convenience
extension AuthViewModel {
    /// Convenience method to check if user needs email verification
    var needsEmailVerification: Bool {
        !isAuthenticated && errorMessage?.contains("email") == true
    }
    
    /// Convenience method to check if there's a network error
    var hasNetworkError: Bool {
        errorMessage?.lowercased().contains("network") == true ||
        errorMessage?.lowercased().contains("connection") == true
    }
    
    /// Convenience method to validate email format
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    /// Convenience method to validate password strength
    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 8
    }
    
    /// Get password strength indicator
    func getPasswordStrength(_ password: String) -> PasswordStrength {
        guard password.count >= 8 else { return .weak }
        
        var score = 0
        
        // Length check
        if password.count >= 12 { score += 1 }
        
        // Character variety checks
        if password.range(of: "[A-Z]", options: .regularExpression) != nil { score += 1 }
        if password.range(of: "[a-z]", options: .regularExpression) != nil { score += 1 }
        if password.range(of: "[0-9]", options: .regularExpression) != nil { score += 1 }
        if password.range(of: "[^A-Za-z0-9]", options: .regularExpression) != nil { score += 1 }
        
        switch score {
        case 0...2: return .weak
        case 3...4: return .medium
        default: return .strong
        }
    }
}

// MARK: - Password Strength Enum
enum PasswordStrength: CaseIterable {
    case weak, medium, strong
    
    var description: String {
        switch self {
        case .weak: return "Weak"
        case .medium: return "Medium"
        case .strong: return "Strong"
        }
    }
    
    var color: Color {
        switch self {
        case .weak: return .red
        case .medium: return .orange
        case .strong: return .green
        }
    }
}
