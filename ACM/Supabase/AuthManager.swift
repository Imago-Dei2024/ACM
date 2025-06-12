import Foundation
import Supabase
import Combine

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

@MainActor
class AuthManager: ObservableObject {
    @Published var session: Session?
    @Published var userProfile: UserProfile?
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var isAuthCheckComplete = false

    private var authTask: Task<Void, Never>?

    // init() is now empty and does not block the main thread.
    init() {}
    
    deinit {
        authTask?.cancel()
    }

    /// Starts listening for authentication state changes from Supabase.
    /// This should be called once when the main app view appears.
    func listenForAuthStateChanges() {
        // Ensure we don't start multiple listeners.
        guard authTask == nil else { return }

        authTask = Task {
            for await authEvent in supabase.auth.authStateChanges {
                self.session = authEvent.session
                
                if authEvent.session != nil {
                    self.fetchUserProfile()
                } else {
                    self.userProfile = nil
                }
                
                // On the first response from Supabase, mark the initial check as complete.
                if !self.isAuthCheckComplete {
                    self.isAuthCheckComplete = true
                }
            }
        }
    }

    // ... (The rest of your functions: signIn, signUp, fetchUserProfile, signOut) ...
    // ... (No changes are needed for the other functions) ...
    
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
