//
//  AuthView.swift
//  ACM
//
//  Created by Connor Laber on 6/15/25.
//

import SwiftUI

/// `AuthView` presents the user with options to log in or create a new account.
/// It interacts with `AuthViewModel` to perform authentication operations.
/// UI updated to reflect modern "Liquid Glass" design principles.
struct AuthView: View {
    /// Accesses the shared authentication state and methods from the environment.
    @EnvironmentObject var authViewModel: AuthViewModel

    /// State for the email input field.
    @State private var email = ""
    /// State for the password input field.
    @State private var password = ""
    /// Controls whether the view is in login or signup mode.
    @State private var isLoginMode = true
    /// Animation state
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            // Background gradient for a more dynamic feel
            LinearGradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                // Glassmorphic container for the form
                VStack(spacing: 22) {
                    // App icon with a modern, integrated look
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(.white.opacity(0.9))
                        .symbolRenderingMode(.hierarchical)
                        .padding(.bottom, 10)


                    // Dynamic title based on login/signup mode
                    Text(isLoginMode ? "Welcome Back!" : "Join ACM")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)


                    // Email input field
                    TextField("Email", text: $email)
                        .padding()
                        .background(.black.opacity(0.2))
                        .cornerRadius(12)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .textContentType(.emailAddress)
                        .foregroundStyle(.white)


                    // Password input field
                    SecureField("Password", text: $password)
                        .padding()
                        .background(.black.opacity(0.2))
                        .cornerRadius(12)
                        .textContentType(.newPassword)
                        .foregroundStyle(.white)


                    // Display error message if present
                    if let errorMessage = authViewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red.opacity(0.9))
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }

                    // Main action button (Log In or Create Account)
                    Button(action: {
                        Task { // Use a Task to perform asynchronous operations
                            if isLoginMode {
                                await authViewModel.signIn(email: email, password: password)
                            } else {
                                await authViewModel.signUp(email: email, password: password)
                            }
                        }
                    }) {
                        Text(isLoginMode ? "Log In" : "Create Account")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.gradient)
                            .cornerRadius(12)
                            .shadow(color: .blue.opacity(0.4), radius: 8, y: 5)
                    }
                    // Disable button if email or password fields are empty
                    .disabled(email.isEmpty || password.isEmpty)
                    .opacity(email.isEmpty || password.isEmpty ? 0.7 : 1.0)


                    // Toggle between login and signup modes
                    Button(action: {
                        withAnimation {
                           isLoginMode.toggle()
                           authViewModel.errorMessage = nil // Clear error message when switching modes
                           email = "" // Clear fields on mode switch for better UX
                           password = ""
                        }
                    }) {
                        Text(isLoginMode ? "Don't have an account? Sign Up" : "Already have an account? Log In")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
                .padding(30)
                .background(.ultraThinMaterial) // Frosted glass effect
                .cornerRadius(25)
                .shadow(color: .black.opacity(0.2), radius: 20, y: 10)
                .padding(.horizontal, 20)
                .scaleEffect(isAnimating ? 1.0 : 0.95)
                .opacity(isAnimating ? 1.0 : 0.0)


                Spacer()
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0)) {
                isAnimating = true
            }
        }
    }
}

/// Provides a preview for `AuthView` in Xcode.
struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .environmentObject(AuthViewModel()) // Inject a mock AuthViewModel for preview
    }
}
