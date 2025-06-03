import SwiftUI

// MARK: - Main Content View with Tab Navigation
// ContentView manages the main tab-based navigation system
struct ContentView: View {
    // State variable to track which tab is currently selected
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Home tab - displays main feed
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            // Search tab - for discovering content
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(1)
            
            // Create tab - for posting new content
            CreatePostView()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Create")
                }
                .tag(2)
            
            // Notifications tab - displays user notifications
            NotificationsView()
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Notifications")
                }
                .tag(3)
            
            // Profile tab - user profile and settings
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(4)
        }
        .accentColor(.blue) // Sets the accent color for selected tab items
    }
}

#Preview {
    ContentView()
}
