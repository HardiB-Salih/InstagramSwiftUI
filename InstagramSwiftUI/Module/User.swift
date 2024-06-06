//
//  User.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import Foundation
import Firebase

struct User: Identifiable , Codable {
    let id: String
    var username: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String
    
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
}

extension User: Hashable { }

extension String {
   static let id = "id"
   static let username = "username"
   static let profileImageUrl = "profileImageUrl"
   static let fullname = "fullname"
   static let bio = "bio"
   static let email = "email"
}
extension User {
    static var MOCK_USERS: [User] {
        return superheroArray.map { hero in
            User(id: UUID().uuidString,
                 username: hero.username,
                 profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-5fffb.appspot.com/o/profile_pictures%2FE50A2EB7-7754-4E33-B06C-C04A89DFE7C3.jpeg?alt=media&token=269792cf-cab7-477d-8ec7-a8afa8372370", 
                 fullname: hero.fullname,
                 email: "\(hero.username)@test.com")
        }
    }
}


