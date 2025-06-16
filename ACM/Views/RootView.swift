//
//  RootView.swift
//  ACM
//
//  Created by Connor Laber on 6/15/25.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var selectedTab = 0
    
    var body: some View {
        Group {
            if authViewModel.isAuthenticated {
                // Show main app when authenticated
                TabView(selection: $selectedTab) {
                    HomeView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                        .tag(0)
                    
                    SearchView()
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                        .tag(1)
                    
                    CreatePostView()
                        .tabItem {
                            Image(systemName: "plus.circle.fill")
                            Text("Create")
                        }
                        .tag(2)
                    
                    NotificationsView()
                        .tabItem {
                            Image(systemName: "heart.fill")
                            Text("Notifications")
                        }
                        .tag(3)
                    
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("Profile")
                        }
                        .tag(4)
                }
                .accentColor(.blue)
            } else {
                // Show authentication view when not authenticated
                AuthView()
            }
        }
        .onAppear {
            // Check authentication status when the view appears
            Task {
                await authViewModel.checkAuthSession()
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(AuthViewModel())
}
