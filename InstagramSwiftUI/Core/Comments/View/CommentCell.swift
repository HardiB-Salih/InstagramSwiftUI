//
//  CommentCell.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/6/24.
//

import SwiftUI
import Firebase

struct CommentCell: View {
    let comment: Comment
    
    var body: some View {
        HStack (alignment: .top){
            RoundedImageView(comment.user?.profileImageUrl, size: .xxSmall, shape: .circle)
            
            VStack (alignment: .leading, spacing: 4) {
                HStack(spacing: 2) {
                    Text(comment.user?.username ?? "")
                        .fontWeight(.semibold)
                    Text(comment.stringTimestamp)
                        .foregroundStyle(.gray)
                }
                
                Text(comment.commentText)
            }
            .font(.caption)
            Spacer()
        }
    }
}

#Preview {
    CommentCell(comment: Comment(commentId: "", commentOwnerId: "", commentText: "This is Comment Test", postId: "", postOwnerId: "", timestamp: Timestamp(), user: User.MOCK_USERS[0]))
}
