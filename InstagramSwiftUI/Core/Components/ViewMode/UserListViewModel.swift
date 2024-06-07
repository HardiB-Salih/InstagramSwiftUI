//
//  UserListViewModel.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/7/24.
//

import Foundation

@MainActor
class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    
    init(){ }
    
    func fetchUsers(config: UserListConfig) async {
        do {
            self.users = try await UserService.fetchUsers(forConfig: config)
        }catch {
            print(error.localizedDescription)
        }
    }
}
