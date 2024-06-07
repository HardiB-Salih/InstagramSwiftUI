//
//  CommentService.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/7/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct CpommentService {
    
    
    static func uploadComment(_ comment: Comment) async throws  {
        do{
            let commentData = try Firestore.Encoder().encode(comment)
            try await FirestoreCollections.posts
                .document(comment.postId)
                .collection(.postComments)
                .addDocument(data: commentData)
            
        } catch {
            throw error
        }
    }
}

extension String {
    static let postComments = "post-comments"
}
