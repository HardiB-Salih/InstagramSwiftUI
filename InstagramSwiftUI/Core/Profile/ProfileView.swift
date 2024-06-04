//
//  ProfileView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct ProfileView: View {
    let user: User
    @Environment(\.dismiss) private var dismiss
    var posts: [Post] {
        return Post.MOCK_POSTS.filter({ $0.user?.username == user.username })
    }
    var body: some View {
        ScrollView {
            //MARK: - Header Area
            ProfileHeaderView(user: user)
                .navigationBarBackButtonHidden()
                .padding(.top)
            
            //MARK: - PostGridView
            PostGridView(posts: posts)
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            topBarLeading()
        }
    }
}

//MARK: -ToolbarContentBuilder
extension ProfileView {
    @ToolbarContentBuilder
    private func topBarLeading() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: { dismiss() }, label: {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .foregroundStyle(Color(.label))
            })
        }
    }
}



#Preview {
    ProfileView(user: User.MOCK_USERS.randomElement()!)
}





