//
//  User.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import Foundation

struct User: Identifiable , Codable {
    let id: String
    var username: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String
    
}

extension User: Hashable { }
extension User {
    static var MOCK_USERS: [User] {
        return superheroArray.map { hero in
            User(id: UUID().uuidString,
                 username: hero.username,
                 profileImageUrl: hero.imagename, 
                 fullname: hero.fullname,
                 email: "\(hero.username)@test.com")
        }
    }
}

