//
//  ProfileHeaderView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    @State private var showEditView = false
    let user : User
    
    var body: some View {
        VStack (spacing: 10) {
            HStack {
                RoundedImageView(user.profileImageUrl, size: .xLarge, shape: .circle)
                    .padding(3)
                    .overlay {
                        Circle()
                            .stroke(Color(.systemGray4), lineWidth: 1.0)
                    }
                
                HStack(spacing: 8) {
                    UserStatView(value: 3, title: "Posts")
                    UserStatView(value: 6, title: "Followers")
                    UserStatView(value: 11, title: "Followring")
                }
                Spacer()
            }
            .padding(.horizontal)
            
            
            VStack (alignment: .leading, spacing: 4){
                Text(user.username)
                    .fontWeight(.semibold)
                if let fullname = user.fullname {
                    Text(fullname)
                }
            }
            .padding(.horizontal)
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Button(action: {
                if user.isCurrentUser {
                    showEditView.toggle()
                } else {
                 print("Follow User")
                }
                
                
            }, label: {
                Text(user.isCurrentUser ? "Edit Profile" : "Follow")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
                    .foregroundStyle(user.isCurrentUser ? Color(.label) : Color(.systemBackground))
                    .background(user.isCurrentUser ? Color(.systemBackground) : Color(.systemBlue))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    }
                    .padding(.horizontal)
            })
            
            Divider()
        }
        .fullScreenCover(isPresented: $showEditView) {
            NavigationStack { EditProfileView(user: user) }
        }
    }
}

//#Preview {
//    ProfileHeaderView(user: User.MOCK_USERS.first!)
//}
