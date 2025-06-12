import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var authManager: AuthManager
    
    // MARK: - State Properties
    @State private var email = ""
    @State private var password = ""
    @State private var fullName = ""
    @State private var isSigningUp = false

    // MARK: - Form Validation
    /// A computed property to check if the form fields are valid for submission.
    private var isFormValid: Bool {
        if !email.contains("@") || !email.contains(".") {
            return false // Simple email format check
        }
        if password.count < 6 {
            return false // Supabase requires at least 6 characters for a password
        }
        if isSigningUp && fullName.isEmpty {
            return false // Full name is required for sign up
        }
        return true
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            // MARK: - Header
            Text(isSigningUp ? "Create Account" : "Welcome Back")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            // MARK: - Input Fields
            Group {
                if isSigningUp {
                    TextField("Full Name", text: $fullName)
                        .textContentType(.name)
                }

                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .textContentType(.emailAddress)

                SecureField("Password (6+ characters)", text: $password)
                    .textContentType(isSigningUp ? .newPassword : .password)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal)
            
            // MARK: - Action Button & Loading Indicator
            if authManager.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else {
                Button(action: handleAuthAction) {
                    Text(isSigningUp ? "Sign Up" : "Login")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isFormValid ? Color.blue : Color.gray) // Change color when disabled
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .disabled(!isFormValid) // Disable button if form is not valid
                .padding(.horizontal)
            }

            // MARK: - Error Message Display
            if !authManager.errorMessage.isEmpty {
                Text(authManager.errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            // MARK: - Toggle Form Type
            Button(action: {
                isSigningUp.toggle()
                authManager.errorMessage = "" // Clear errors when switching forms
            }) {
                Text(isSigningUp ? "Already have an account? Login" : "Don't have an account? Sign Up")
                    .foregroundColor(.blue)
            }
            .padding(.top)

            Spacer()
        }
        .animation(.easeInOut, value: isSigningUp)
        .animation(.easeInOut, value: isFormValid)
    }
    
    /// Determines whether to call the sign-in or sign-up function.
    private func handleAuthAction() {
        Task {
            if isSigningUp {
                await authManager.signUp(email: email, password: password, fullName: fullName)
            } else {
                await authManager.signIn(email: email, password: password)
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
            .environmentObject(AuthManager())
    }
}

