//
//  NotificationViewModel.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/7/24.
//

import Foundation

@MainActor
class NotificationViewModel: ObservableObject {
    
    @Published var notifications : [Notification] = []
    private let service : NotificationService
    
    init(service : NotificationService){
        self.service = service
        fetchNatifications()
    }
    
    func fetchNatifications() {
        Task {
            self.notifications = try await service.fetchNotifications()
            try await updateNotification()
        }
    }
    
    func updateNotification() async throws {
        for i in notifications.indices {
            var notification = notifications[i]
               
            notification.user = try await UserService.fetchUserBy(userId: notification.notificationSenderUid)
            
            if let postId =  notification.postId  {
                notification.post = try await PostService.fetchPost(forPostId: postId)
                notification.post?.user = UserService.currentUser
            }
            
            self.notifications[i] = notification
        }
    }
}
