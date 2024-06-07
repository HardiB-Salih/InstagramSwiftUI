//
//  Notification.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/7/24.
//

import Firebase

struct Notification : Identifiable ,Codable {
    let id: String
    var postId: String?
    let timestamp: Timestamp
    let notificationSenderUid: String
    let type: NotificationType
    
    var post: Post?
    var user: User?
    
}

extension Notification {
    static var MOCK_Notifications: [Notification] {
        return superheroArray.enumerated().map { (index, hero) in
            let user = User.MOCK_USERS[index]
            let post = Post.MOCK_POSTS[index]
            return Notification(
                id: UUID().uuidString,
                postId: post.id,
                timestamp: Timestamp(),
                notificationSenderUid: user.id,
                type: randomNotificationType(),
                post: post, 
                user: user )
        }
    }
    
    private static func randomNotificationType() -> NotificationType {
            let types: [NotificationType] = [.like, .comment, .follow]
            return types.randomElement()!
        }
}
