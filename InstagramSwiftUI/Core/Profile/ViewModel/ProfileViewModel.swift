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
        fetchUserStats()
        checkIfUserFollowed()
    }
    
    func fetchUserStats() {
        Task {
            self.user.userStats = try await UserService.fetchUserStats(uid: user.id)
        }
    }
}


extension ProfileViewModel {
    func follow() {
        Task {
            try await UserService.follow(uid: user.id)
            user.isFollowed = true
            NotificationManager.shared.uploadFollowNotification(toUid: user.id)
        }
    }
    
    func unFollow() {
        Task {
            try await UserService.unfollow(uid: user.id)
            user.isFollowed = false
            NotificationManager.shared.deleteFollowNotification(toUid: user.id)
        }
    }
    
    func checkIfUserFollowed() {
//        guard user.isFollowed == nil else { return }
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
