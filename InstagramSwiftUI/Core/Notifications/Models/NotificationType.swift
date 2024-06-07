//
//  NotificationType.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/7/24.
//

import Foundation
enum NotificationType: Int, Codable {
    case like
    case comment
    case follow
    
    var notificationMessage: String {
        switch self {
        case .like: return "liked one of your post."
        case .comment: return "commented on one of your post."
        case .follow: return "start following you."
        }
    }
    
    
}
