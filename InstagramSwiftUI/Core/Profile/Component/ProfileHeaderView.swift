//
//  ProfileHeaderView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user : User
    
    var body: some View {
        VStack (spacing: 10) {
            HStack {
                Image(user.profileImageUrl ?? "iron-man")
                    .resizable()
                    .clipShape(Circle())
                    .padding(3)
                    .overlay { Circle().stroke(Color(.systemGray5), lineWidth: 1) }
                    .frame(width: 100, height: 100)
                
                
                
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
            
            
            Button(action: {}, label: {
                Text("Edit Profile")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .foregroundStyle(Color(.label))
                    .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: 7, style: .continuous)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    }
                    .padding(.horizontal)
            })
            
            Divider()
        }
    }
}
