//
//  CommentViewModel.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/7/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import Combine

@MainActor
class CommentViewModel: ObservableObject {
    @Published var commentText = ""
    @Published var comments: [Comment] = []
    
    private var listener: ListenerRegistration?
    
    private var post: Post
    
    init(post: Post) {
        self.post = post
        
        fetchComments()
    }
    
    deinit {
        listener?.remove()
        listener = nil
    }
    
    func uploadComment() async {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let comment = Comment(commentOwnerId: currentUid,
                              commentText: commentText,
                              postId: post.id,
                              postOwnerId: post.ownerUid,
                              timestamp: Timestamp())
        
        do {
            try await CpommentService.uploadComment(comment)
            NotificationManager.shared.uploadCommentNotification(toUid: post.ownerUid, post: post)
        } catch {
            print("🙀 could not upload comment")
        }
    }
    
    func fetchComments() {
        let commentQuery = FirestoreCollections.posts
            .document(post.id)
            .collection(.postComments)
            
        listener = commentQuery
            .order(by: .timestamp , descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching posts: \(error)")
                return
            }
            
            Task {
                var updatedComments: [Comment] = []
                
                for document in snapshot?.documents ?? [] {
                    if let comment = try? document.data(as: Comment.self) {
                        var updatedComment = comment
                        let commentOwnerId = comment.commentOwnerId
                        do {
                            let commentUser = try await UserService.fetchUserBy(userId: commentOwnerId)
                            updatedComment.user = commentUser
                        } catch {
                            print("Error fetching user for post: \(error)")
                        }
                        updatedComments.append(updatedComment)
                    }
                }
                self.comments = updatedComments
            }
        }
    }
}
