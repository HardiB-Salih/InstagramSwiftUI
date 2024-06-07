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
            post.didLike = true
            try await PostService.likePost(postCopy)
            NotificationManager.shared.uploadLikeNotification(toUid: post.ownerUid, post: post)
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
            post.didLike = false
            try await PostService.unLikePost(postCopy)
            NotificationManager.shared.deleteLikeNotification(toUid: post.ownerUid, post: post)
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
