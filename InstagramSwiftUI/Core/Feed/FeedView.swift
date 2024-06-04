//
//  FeedView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct FeedView: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack (spacing: 12){
                    ForEach(Post.MOCK_POSTS) { post in
                        FeedCell(post: post)
                            .padding(.top)
                    }
                }
            }
            .navigationTitle("Feed")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                topBarLeading()
                topBarTrailing()
            }
        }
    }
}

//MARK: - ToolbarContentBuilder
extension FeedView {
    @ToolbarContentBuilder
    private func topBarLeading() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Image("Instagram_logo")
                .resizable()
                .frame(width: 100, height: 32)
        }
    }
    
    @ToolbarContentBuilder
    private func topBarTrailing() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Image(systemName: "paperplane")
                .imageScale(.large)
        }
    }
}


#Preview {
    FeedView()
}
