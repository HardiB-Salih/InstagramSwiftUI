//
//  SearchViewModel.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/5/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users: [User] = []
    
    init(){
        Task { await fetchUsers() }
    }
    
    @MainActor
    private func fetchUsers() async {
        do {
            users = try await UserService.shared.fetchAllUsers()
        } catch {
            print("🙀 Where is users? \(error.localizedDescription)")
        }
    }
}
