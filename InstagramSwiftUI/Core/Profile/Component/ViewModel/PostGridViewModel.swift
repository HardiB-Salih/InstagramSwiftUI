//
//  PostGridViewModel.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/6/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import Combine


import Foundation
import Firebase
import FirebaseFirestoreSwift

class PostGridViewModel: ObservableObject {
    private let user: User
    @Published var posts: [Post] = []
    private var listener: ListenerRegistration?
    
    init(user: User) {
        self.user = user
        fetchPosts()
    }
    
    deinit {
        listener?.remove()
        listener = nil
    }
    
    func fetchPosts() {
        let postQuery = FirestoreCollections.posts
            .whereField(.ownerUid, isEqualTo: user.id)
        
        listener = postQuery.addSnapshotListener { [weak self] snapshot, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching posts: \(error)")
                return
            }
            
            Task {
                var updatedPosts: [Post] = []
                for document in snapshot?.documents ?? [] {
                    if let post = try? document.data(as: Post.self) {
                        var updatedPost = post
                        updatedPost.user = self.user
                        
                        updatedPosts.append(updatedPost)
                    }
                }
                
                let sortedPost = updatedPosts.sorted(by: { $0.timestamp > $1.timestamp })

                DispatchQueue.main.async {
                    self.posts = sortedPost
                }
            }
        }
    }
}
