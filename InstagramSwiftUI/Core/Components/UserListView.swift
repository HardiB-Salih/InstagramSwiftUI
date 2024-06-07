//
//  UserListView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/7/24.
//

import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserListViewModel()
    @State private var searchText = ""
    
    private let config: UserListConfig
    init(config: UserListConfig) {
        self.config = config
    }
    var body: some View {
        ScrollView {
            LazyVStack (spacing: 8){
                ForEach(viewModel.users) { user in
                    NavigationLink(value: user) {
                        SearchCell(user: user)
                    }
                }
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            .searchable(text: $searchText)
        }
        .task {
            await viewModel.fetchUsers(config: config)
        }
        .scrollIndicators(.hidden)
        .navigationTitle(config.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    UserListView(config: .explore)
}
