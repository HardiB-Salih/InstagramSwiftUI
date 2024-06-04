//
//  Post.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import Foundation

struct Post : Identifiable, Codable {
    let id: String
    let ownerUid: String
    let caption: String
    var like: Int
    let imageUrl: String
    let timestamp: Date
    let user: User?
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
                like: Int.random(in: 0...1000000),
                imageUrl: hero.imagename,
                timestamp: Date(),
                user: user
            )
        }
    }
}
