//
//  FeedCell.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    @State private var isAnimating = false
    @State private var showCommentView = false
    @ObservedObject private var viewModel : FeedCellViewModel
    var post: Post {
        return viewModel.post
    }
    
    var didLike: Bool {
        return self.post.didLike ?? false
    }
    
    init(post: Post) {
        self.viewModel = FeedCellViewModel(post: post)
    }
    
    
    private func handleLikeTapped() {
        Task {
            if didLike {
                await viewModel.unLike()
                print("🤷 didLike is \(didLike)")
            } else {
                await viewModel.like()
                print("🙀 didLike is \(didLike)")
            }
        }
    }
    
    
    var body: some View {
        VStack (spacing: 0){
            //MARK: - Image + username
            HStack {
                RoundedImageView(post.user?.profileImageUrl, size: .xSmall, shape: .circle)
                    .padding(3)
                    .overlay {
                        Circle()
                            .stroke(Color(.systemGray4), lineWidth: 1.0)
                    }
                
                
                Text(post.user?.username ?? "")
                    .font(.footnote)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .padding(.leading, 8)
            .padding(.bottom, 8)
            
            //MARK: - Post Image
            KFImage(post.postImageURL)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 400)
                .clipShape(Rectangle())
            
            //MARK: - Action Buttons
            HStack(spacing: 16) {
                Button(action: {
                    handleLikeTapped()
                    withAnimation(.smooth(duration: 0.3)) {
                        isAnimating = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isAnimating = false
                    }
                }, label: {
                    Image(systemName: didLike ? "suit.heart.fill" : "suit.heart")
                        .foregroundStyle(Color(didLike ? .systemRed : .label))
                        .font(.system(size: 20))
                        .imageScale(.large)
                        .scaleEffect(isAnimating ? 1.4 : 1.0)
                    
                })
                
                Button(action: {
                    showCommentView = true
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
            if post.likes > 0 && post.likes != 0  {
                Text("\(post.likes) Likes")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 12)
            }
            
            
            
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
            Text(post.stringTimestamp)
                .font(.footnote)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 12)
                .foregroundStyle(Color(.systemGray))
        }
        .sheet(isPresented: $showCommentView, content: {
            CommentView(post: post)
                .presentationDragIndicator(.visible)
        })
    }
}

#Preview {
    FeedCell(post: Post.MOCK_POSTS[1])
}
