//
//  FeedCellViewModel.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/6/24.
//

import Foundation

@MainActor
class FeedCellViewModel: ObservableObject {
    @Published var post: Post
    
    
    init(post: Post) {
        self.post = post
        Task {
            await checkIfUserLikePost()
        }
    }
    
    func like() async {
        let postCopy = post
        post.didLike = true
        post.likes += 1
        do {
            try await PostService.likePost(postCopy)
        } catch {
            print(error.localizedDescription)
            post.didLike = false
            post.likes -= 1
        }
    }
    
    func unLike() async {
        let postCopy = post
        post.didLike = false
        post.likes -= 1
        do {
            try await PostService.unLikePost(postCopy)
        } catch {
            print(error.localizedDescription)
            post.didLike = true
            post.likes += 1
        }
    }
    
    func checkIfUserLikePost() async {
        do {
            self.post.didLike = try await PostService.checkIfUserLikePost(post)
        } catch {
            print("🙀 Network issue")
        }
       
    }
    
}
