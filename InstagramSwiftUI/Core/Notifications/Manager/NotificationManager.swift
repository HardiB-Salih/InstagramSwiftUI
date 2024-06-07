//
//  NotificationManager.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/7/24.
//

import Foundation

class NotificationManager {
    static let shared = NotificationManager()
    private let service = NotificationService()

    private init() { }
    
    func uploadLikeNotification(toUid uid: String, post: Post) {
        service.uploadNotification(toUid: uid, type: .like, post: post)
    }
    
    func uploadCommentNotification(toUid uid: String, post: Post) {
        service.uploadNotification(toUid: uid, type: .comment, post: post)
    }
    
    func uploadFollowNotification(toUid uid: String) {
        service.uploadNotification(toUid: uid, type: .follow)
    }
    
    func deleteLikeNotification(toUid uid: String, post: Post) {
        service.deleteNotification(toUid: uid, type: .like, post: post)
    }
    
    func deleteCommentNotification(toUid uid: String, post: Post) {
        service.deleteNotification(toUid: uid, type: .comment, post: post)
    }
    
    func deleteFollowNotification(toUid uid: String) {
        service.deleteNotification(toUid: uid, type: .follow)
    }
}
