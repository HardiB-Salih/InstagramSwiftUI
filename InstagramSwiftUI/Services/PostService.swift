//
//  PostService.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/6/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import Combine

struct PostService {

    static func fetchPosts(forUserId uid: String) async throws -> [Post] {
        let snapshot = try await FirestoreCollections.posts.whereField(.ownerUid , isEqualTo: uid).getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: Post.self) })
    }
}

//MARK: - Like
extension PostService {
    
    /// Likes a post by updating the Firestore database with necessary changes.
    /// - Parameter post: The post to be liked.
    /// - Throws: An error if the current user ID cannot be retrieved or if any Firestore operation fails.
    static func likePost(_ post: Post) async throws {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        let postLikesRef = FirestoreCollections.posts.document(post.id).collection(.postLikes).document(currentUserId)
        let userLikesRef = FirestoreCollections.users.document(currentUserId).collection(.userLikes).document(post.id)
        let postRef = FirestoreCollections.posts.document(post.id)
        
        let addLike: [String: Any] = [.likes : post.likes + 1]
        
        do {
            async let postLike: Void = postLikesRef.setData([:])
            async let postUpdate: Void = postRef.updateData(addLike)
            async let userLike: Void = userLikesRef.setData([:])
            
            // Await all tasks to ensure they complete
            _ = try await (postLike, postUpdate, userLike)
        } catch {
            throw error
        }
    }
    
    /// Unlikes a post by updating the Firestore database with necessary changes.
    /// - Parameter post: The post to be unliked.
    /// - Throws: An error if the current user ID cannot be retrieved or if any Firestore operation fails.
    static func unLikePost(_ post: Post) async throws {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        let postLikesRef = FirestoreCollections.posts.document(post.id).collection(.postLikes).document(currentUserId)
        let userLikesRef = FirestoreCollections.users.document(currentUserId).collection(.userLikes).document(post.id)
        let postRef = FirestoreCollections.posts.document(post.id)
        
        let removeLike: [String: Any] = [.likes: post.likes - 1]
        
        do {
            async let postLikeDelete: Void = postLikesRef.delete()
            async let postUpdate: Void = postRef.updateData(removeLike)
            async let userLikeDelete: Void = userLikesRef.delete()
            
            // Await all tasks to ensure they complete
            _ = try await (postLikeDelete, postUpdate, userLikeDelete)
        } catch {
            throw error
        }
    }
    
    /// Checks if the current user has liked a specific post.
    /// - Parameter post: The post to check for a like.
    /// - Returns: A boolean indicating whether the user has liked the post.
    /// - Throws: An error if the current user ID cannot be retrieved or if any Firestore operation fails.
    static func checkIfUserLikePost(_ post: Post) async throws -> Bool {
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            // If the current user ID cannot be retrieved, throw an error
            throw NSError(domain: "AuthError", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])
        }

        let snapshot = try await FirestoreCollections.users.document(currentUserId).collection(.userLikes).document(post.id).getDocument()
        return snapshot.exists
    }
}


extension String {
    static let postLikes = "post-likes"
    static let userLikes = "user-likes"

}
