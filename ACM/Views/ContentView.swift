import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            //Home Tab - Displays main feed
            HomeView()
                .tabItem {
                    Image(systemName:"house.fill")
                    Text("Home")
                }
                .tag(0)
            
            // Search Tab - for discovering content
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(1)
            
            //Create tab - for posting new content
            CreatePostView()
                .tabItem{
                    Image(systemName: "plus.circle.fill")
                    Text("Create")
                }
                .tag(2)
            
            //Notifcations Tab - displays users notifications
            NotificationsView()
                .tabItem{
                    Image(systemName: "heart.fill")
                    Text("Notifications")
                }
                .tag(3)
            
            //Profile tab - user profile and settings
            ProfileView()
                .tabItem{
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
                .tag(4)
        }
        .accentColor(.blue) // Sets accent color for selected tab items 
    }
}
