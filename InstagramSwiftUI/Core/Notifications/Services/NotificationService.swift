//
//  NotificationService.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/7/24.
//

import Firebase
import FirebaseFirestoreSwift

class NotificationService {
    
    
    func fetchNotifications() async throws -> [Notification] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
        
        let snapshot = try await FirestoreCollections.notifications
            .document(currentUid)
            .collection("user-notifications")
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Notification.self) })
    }
    
    func uploadNotification(toUid uid: String, type: NotificationType, post: Post? = nil) {
        guard let currentUid = Auth.auth().currentUser?.uid, uid != currentUid else { return }
        
        let ref = FirestoreCollections.notifications.document(uid).collection("user-notifications").document()
        
        let notification = Notification(id: ref.documentID,
                                        postId: post?.id,
                                        timestamp: Timestamp(),
                                        notificationSenderUid: currentUid,
                                        type: type)
        guard let notificationEncode = try? Firestore.Encoder().encode(notification) else { return }
        ref.setData(notificationEncode)
        
    }
    
    func deleteNotification(toUid uid: String, type: NotificationType, post: Post? = nil) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let ref = FirestoreCollections.notifications.document(uid).collection("user-notifications")
        
        var query = ref.whereField("notificationSenderUid", isEqualTo: currentUid)
            .whereField("type", isEqualTo: type.rawValue)
        
        if let postId = post?.id {
            query = query.whereField("postId", isEqualTo: postId)
        }
        
        query.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            for document in documents {
                document.reference.delete { error in
                    if let error = error {
                        print("Error deleting document: \(error)")
                    } else {
                        print("Document successfully deleted")
                    }
                }
            }
        }
    }
    
    
    
    
}
