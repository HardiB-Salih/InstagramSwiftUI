//
//  FeedCell.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct FeedCell: View {
    let post : Post
    
    
    var body: some View {
        VStack (spacing: 0){
            //MARK: - Image + username
            HStack {
                Image(post.user?.profileImageUrl ?? "iron-man")
                    .resizable()
                    .clipShape(Circle())
                    .padding(3)
                    .overlay { Circle().stroke(Color(.systemGray5), lineWidth: 1) }
                    .frame(width: 40, height: 40)
                
                Text(post.user?.username ?? "")
                    .font(.footnote)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(.leading, 8)
            .padding(.bottom, 8)
            
            //MARK: - Post Image
            Image(MockSamples.photos.randomElement() ?? "iron-man")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 400)
                .clipShape(Rectangle())
            
            //MARK: - Action Buttons
            HStack(spacing: 16) {
                Button(action: {
                    print("Like a Post")
                }, label: {
                    Image(systemName: "suit.heart")
                        .font(.system(size: 20))
                        .imageScale(.large)
                })
                
                Button(action: {
                    print("Comment on Post")
                }, label: {
                    Image(systemName: "bubble.right")
                        .font(.system(size: 18))
                        .imageScale(.large)
                })
                
                Button(action: {
                    print("Share Post")
                }, label: {
                    Image(systemName: "paperplane")
                        .font(.system(size: 18))
                        .imageScale(.large)
                })
                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .foregroundStyle(Color(.label))
            
            //MARK: - Like label
            Text("\(post.like) Likes")
                .font(.footnote)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 12)
                
            
            //MARK: - Caption label
            HStack {
                Text(post.user?.username ?? "").fontWeight(.semibold)
                +
                Text(" \(post.caption)")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.footnote)
            .padding(.leading, 12)
            .padding(.vertical, 4)
            
            //MARK: - Timestamp
            Text("6h ago")
                .font(.footnote)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 12)
                .foregroundStyle(Color(.systemGray))
        }
    }
}

#Preview {
    FeedCell(post: Post.MOCK_POSTS.randomElement()!)
}
