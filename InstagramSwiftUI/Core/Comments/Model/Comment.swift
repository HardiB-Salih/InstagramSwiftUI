//
//  Comment.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/7/24.
//

import Firebase
import FirebaseFirestoreSwift

struct Comment: Identifiable, Codable, Hashable {
    @DocumentID var commentId: String?
    let commentOwnerId: String
    let commentText: String
    let postId: String
    let postOwnerId: String
    let timestamp: Timestamp
    
    var user: User?
    
    var id: String {
        return commentId ?? UUID().uuidString
    }
    
    var stringTimestamp : String {
        return timestamp.timestampString()
    }
}
