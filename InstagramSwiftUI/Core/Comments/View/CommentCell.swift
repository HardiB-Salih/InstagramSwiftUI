//
//  CommentCell.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/6/24.
//

import SwiftUI

struct CommentCell: View {
    
    private var user: User {
        return User.MOCK_USERS[0]
    }
    var body: some View {
        HStack (alignment: .top){
            RoundedImageView(user.profileImageUrl, size: .xxSmall, shape: .circle)
            
            VStack (alignment: .leading, spacing: 4) {
                HStack(spacing: 2) {
                    Text(user.username)
                        .fontWeight(.semibold)
                    Text("6d")
                        .foregroundStyle(.gray)
                }
                
                Text("This is a Comment")
            }
            .font(.caption)
            Spacer()
        }
    }
}

#Preview {
    CommentCell()
}
