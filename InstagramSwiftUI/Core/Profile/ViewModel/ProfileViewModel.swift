//
//  ProfileViewModel.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/7/24.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
        checkIfUserFollowed()
    }
}


extension ProfileViewModel {
    func follow() {
        Task {
            try await UserService.follow(uid: user.id)
            user.isFollowed = true
        }
    }
    func unFollow() {
        Task {
            try await UserService.unfollow(uid: user.id)
            user.isFollowed = false
        }
    }
    
    func checkIfUserFollowed() {
        UserService.checkIfUserFollowed(uid: user.id) { result in
            switch result {
            case .success(let success):
                self.user.isFollowed = success
            case .failure(_):
                print("🙀 Could not find it")
            }
        }
    }
    
}
