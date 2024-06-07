//
//  UserListConfig.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/7/24.
//

import Foundation

enum UserListConfig : Hashable {
    case followers(uid: String)
    case following(uid: String)
    case likes(postId: String)
    case explore
    
    
    var navigationTitle: String {
        switch self {
        case .followers( _ ):
            return "Followers"
        case .following( _ ):
            return "Following"
        case .likes( _ ):
            return "Likes"
        case .explore:
            return "Explore"
        }
    }
    
    
}
