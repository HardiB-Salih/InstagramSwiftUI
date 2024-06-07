//
//  CommentView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/6/24.
//

import SwiftUI

struct CommentView: View {
    @StateObject private var viewModel: CommentViewModel
    var currentUser: User? {
        return UserService.currentUser
    }
    let post : Post
    
    init(post: Post) {
        self.post = post
        self._viewModel = StateObject(wrappedValue: CommentViewModel(post: post))
    }
    
    let colors = [Color.red, Color.blue, Color.pink, Color.yellow, Color.red]
    
    var body: some View {
        VStack {
            Text("Comments")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
            
            Divider()
            
            ScrollView {
                LazyVStack (spacing: 12){
                    ForEach(viewModel.comments) { comment in
                        CommentCell(comment: comment)
                            .padding(.horizontal)
                    }
                }
                
            }
            .scrollIndicators(.hidden)
            
            
            HStack (alignment: .bottom) {
                RoundedImageView(currentUser?.profileImageUrl,
                                 size: .xSmall,
                                 shape: .rounded(cornerRadius: 16))
                    .padding(2)
                    .overlay{
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .stroke(LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing) , lineWidth: 1.0)
                    }
                
                HStack (alignment: .bottom){
                    TextField("Add a comment", text: $viewModel.commentText, axis: .vertical)
                        .font(.footnote)
                    
                    Button(action: {
                        Task {
                            await viewModel.uploadComment()
                            viewModel.commentText = ""
                        }
                        
                    }, label: {
                        Text("Post")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    })
                    .disabled(viewModel.commentText.isEmpty)
                }
                .padding(12)
                .overlay{
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color(.systemGray5) , lineWidth: 1.0)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    CommentView(post: Post.MOCK_POSTS[0])
}
