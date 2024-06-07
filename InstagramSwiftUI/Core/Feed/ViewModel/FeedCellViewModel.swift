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
        checkIfUserLikePost()
    }
    
    func like() async {
        
        do {
            let postCopy = post
            post.likes += 1
            try await PostService.likePost(postCopy)
            post.didLike = true
        } catch {
            print(error.localizedDescription)
            post.didLike = false
            post.likes -= 1
        }
    }
    
    func unLike() async {
        do {
            let postCopy = post
            post.likes -= 1
            try await PostService.unLikePost(postCopy)
            post.didLike = false
        } catch {
            print(error.localizedDescription)
            post.didLike = true
            post.likes += 1
        }
    }
    
    func checkIfUserLikePost() {
        PostService.checkIfUserLikePost(post) { result in
            switch result {
            case .success(let didLike):
                self.post.didLike = didLike
            case .failure(_):
                print("🙀 You Did Not Like this Post")
            }
        }
    }
}
