//
//  AuthView.swift
//  ACM
//
//  Created by Connor Laber on 6/15/25.
//

import SwiftUI

   /// `AuthView` presents the user with options to log in or create a new account.
   /// It interacts with `AuthViewModel` to perform authentication operations.
   struct AuthView: View {
       /// Accesses the shared authentication state and methods from the environment.
       @EnvironmentObject var authViewModel: AuthViewModel

       /// State for the email input field.
       @State private var email = ""
       /// State for the password input field.
       @State private var password = ""
       /// Controls whether the view is in login or signup mode.
       @State private var isLoginMode = true

       var body: some View {
           NavigationView {
               VStack(spacing: 20) {
                   Spacer()

                   // App icon or placeholder image
                   Image(systemName: "person.circle.fill")
                       .resizable()
                       .scaledToFit()
                       .frame(width: 100, height: 100)
                       .foregroundColor(.blue)

                   // Dynamic title based on login/signup mode
                   Text(isLoginMode ? "Welcome Back!" : "Join ACM")
                       .font(.largeTitle)
                       .fontWeight(.bold)
                       .padding(.bottom, 10)

                   // Email input field
                   TextField("Email", text: $email)
                       .padding()
                       .background(Color(.systemGray6))
                       .cornerRadius(10)
                       .keyboardType(.emailAddress)
                       .autocapitalization(.none)
                       .disableAutocorrection(true)
                       .textContentType(.emailAddress) // Helps with autofill

                   // Password input field
                   SecureField("Password", text: $password)
                       .padding()
                       .background(Color(.systemGray6))
                       .cornerRadius(10)
                       .textContentType(.newPassword) // Helps with password autofill/suggestions

                   // Display error message if present
                   if let errorMessage = authViewModel.errorMessage {
                       Text(errorMessage)
                           .foregroundColor(.red)
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
                           .background(Color.blue)
                           .cornerRadius(10)
                   }
                   // Disable button if email or password fields are empty
                   .disabled(email.isEmpty || password.isEmpty)

                   // Toggle between login and signup modes
                   Button(action: {
                       isLoginMode.toggle()
                       authViewModel.errorMessage = nil // Clear error message when switching modes
                       email = "" // Clear fields on mode switch for better UX
                       password = ""
                   }) {
                       Text(isLoginMode ? "Don't have an account? Sign Up" : "Already have an account? Log In")
                           .font(.subheadline)
                           .foregroundColor(.blue)
                   }

                   Spacer()
               }
               .padding()
               // Hide navigation bar for a cleaner full-screen authentication experience
               .navigationTitle("") // Empty title
               .navigationBarHidden(true) // Hide the navigation bar
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
   
