//
//  PostGridView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct PostGridView: View {
    var posts : [Post]
    
    private let gridItems : [GridItem] = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 2) {
            ForEach(posts) { post in
                Image(post.imageUrl)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 3, style: .continuous))
            }
        }
    }
}

#Preview {
    PostGridView(posts: Post.MOCK_POSTS)
}
