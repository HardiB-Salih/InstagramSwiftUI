//
//  Post.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import Foundation
import Firebase
struct Post : Identifiable, Codable {
    let id: String
    let ownerUid: String
    let caption: String
    var likes: Int
    let imageUrl: String
    let timestamp: Timestamp
    
    var user: User?
    var didLike: Bool? = false
    var postImageURL: URL? {
        return URL(string: imageUrl)
    }
    
    var stringTimestamp: String {
        return timestamp.timestampString()
    }
    
}

extension Post: Hashable { }

extension Post {
    static var MOCK_POSTS: [Post] {
        return superheroArray.enumerated().map { (index, hero) in
            let user = User.MOCK_USERS[index]
            return Post(
                id: UUID().uuidString,
                ownerUid: user.username,
                caption: "This is a post by \(user.fullname ?? "")",
                likes: Int.random(in: 0...1000000),
                imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-5fffb.appspot.com/o/profile_pictures%2FE50A2EB7-7754-4E33-B06C-C04A89DFE7C3.jpeg?alt=media&token=269792cf-cab7-477d-8ec7-a8afa8372370",
                timestamp: Timestamp(),
                user: user
            )
        }
    }
}

extension String {
    static let timestamp =  "timestamp"
    static let ownerUid = "ownerUid"
    static let likes = "likes"
}
