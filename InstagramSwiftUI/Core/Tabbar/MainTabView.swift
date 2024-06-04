//
//  MainTabView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var showCreateThread = false
    @Namespace private var tabAnimation
    
    init(){
        UIManager.setNavigationBarBackgroundColor(UIColor.secondarySystemBackground)
        UIManager.changeTabBarBackgroundColor(to: UIColor.secondarySystemBackground)
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            //MARK: - FeedView
            FeedView()
                .tabItem {
                        Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                            .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                    
                }
                .onAppear { selectedTab = 0 }
                .tag(0)
            
            //MARK: - SearchView
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .onAppear { selectedTab = 1 }
                .tag(1)
            
            //MARK: - CreatePostView
            UploadPostView()
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "plus.app.fill" : "plus.app")
                        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                }
                .onAppear { selectedTab = 2 }
                .tag(2)
            
            //MARK: - Notification
            Text("Notification")
                .tabItem {
                    Image(systemName: selectedTab == 3 ? "heart.fill" : "heart")
                        .environment(\.symbolVariants, selectedTab == 3 ? .fill : .none)
                }
                .onAppear { selectedTab = 3 }
                .tag(3)
            
            //MARK: - ProfileView
            CurrentUserProfileView(user: User.MOCK_USERS.randomElement()!)
                .tabItem {
                    Image(systemName: selectedTab == 4 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 4 ? .fill : .none)
                }
                .onAppear { selectedTab = 4 }
                .tag(4)
            
        }
        .onChange(of: selectedTab, { oldValue, newValue in
            withAnimation(.smooth) {
                if newValue == 2 {
                    showCreateThread = true
                    selectedTab = oldValue
                    // or use one of the tab as a selected tab
                }
            }
        })
        .sheet(isPresented: $showCreateThread) {
            UploadPostView()
        }
        .tint(Color(.label))
    }
}

#Preview {
    MainTabView()
}
