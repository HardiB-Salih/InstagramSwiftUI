//
//  CurrentUserProfileView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct CurrentUserProfileView: View {
    let user: User
    
    var posts: [Post] {
        return Post.MOCK_POSTS.filter({ $0.user?.username == self.user.username })
    }
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                //MARK: - Header Area
                ProfileHeaderView(user: user)
                    .padding(.top)
                
                //MARK: - PostGridView
                PostGridView(posts: posts)
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                topBarTrailing()
            }
        }
    }
}

//MARK: -ToolbarContentBuilder
extension CurrentUserProfileView {
    @ToolbarContentBuilder
    private func topBarTrailing() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: {}, label: {
                Text("Sign out")
                    .font(.headline)
                    .foregroundStyle(Color(.label))
            })
            
        }
    }
}


#Preview {
    CurrentUserProfileView(user: User.MOCK_USERS.randomElement()!)
}


