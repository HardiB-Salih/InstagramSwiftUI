//
//  FeedViewModel.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/6/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import Combine

@MainActor
class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    private var listener: ListenerRegistration?
    
    init() {
        fetchPosts()
    }
    
    deinit {
        listener?.remove()
        listener = nil
    }
    
    func fetchPosts() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        let postQuery = FirestoreCollections.posts
            .whereField(.ownerUid, isNotEqualTo: currentUserId)
            .order(by: .timestamp, descending: true)
        
        listener = postQuery.addSnapshotListener { [weak self] snapshot, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching posts: \(error)")
                return
            }
            
            Task {
                var updatedPosts: [Post] = []
                let documents = snapshot?.documents ?? []

                for document in documents {
                    if let post = try? document.data(as: Post.self) {
                        var updatedPost = post
                        let ownerId = post.ownerUid
                        
                        async let postUser = UserService.fetchUserBy(userId: ownerId)
//                        async let didLike = PostService.checkIfUserLikePost(post)

                        do {
                            updatedPost.user = try await postUser
//                            updatedPost.didLike = try await didLike
                        } catch {
                            print("Error fetching user or post like status: \(error)")
                        }

                        updatedPosts.append(updatedPost)
                    }
                }
                
                self.posts = updatedPosts
            }
        }
    }


//    func fetchPosts() {
//        let postQuery = FirestoreCollections.posts
//            .order(by: .timestamp , descending: true)
//        
//        listener = postQuery.addSnapshotListener { [weak self] snapshot, error in
//            guard let self = self else { return }
//            if let error = error {
//                print("Error fetching posts: \(error)")
//                return
//            }
//            
//            Task {
//                var updatedPosts: [Post] = []
//                
//                for document in snapshot?.documents ?? [] {
//                    if let post = try? document.data(as: Post.self) {
//                        var updatedPost = post
//                        let ownerId = post.ownerUid
//                        do {
//                            let postUser = try await UserService.shared.fetchUserBy(userId: ownerId)
//                            updatedPost.didLike = try await PostService.checkIfUserLikePost(updatedPost)
//                            print("didLike 🚀")
//                            updatedPost.user = postUser
//                        } catch {
//                            print("Error fetching user for post: \(error)")
//                        }
//                        updatedPosts.append(updatedPost)
//                    }
//                }
//                
//                DispatchQueue.main.async {
//                    self.posts = updatedPosts
//                }
//            }
//        }
//    }
}
