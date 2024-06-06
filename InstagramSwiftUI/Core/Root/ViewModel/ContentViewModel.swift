//
//  ContentViewModel.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import Foundation
import FirebaseAuth
import Combine

@MainActor
class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    private var cancellables = Set<AnyCancellable>()


    
    init() {
        setUpSubscribers()
    }

    private func setUpSubscribers() {
        AuthService.shared.$userSession
            .receive(on: DispatchQueue.main)
            .sink { [weak self] userSession in
                guard let self else { return }
                guard let userSession else { return }
                self.userSession = userSession
                self.fetchCurrentUser()
            }
            .store(in: &cancellables)
    }

    private func fetchCurrentUser() {
        guard userSession != nil else { return }

        Task {
            do {
                self.currentUser = try await UserService.shared.fetchCurrentUser()
                print("✅ Current User \(String(describing: self.currentUser?.id))")
            } catch {
                print("❌ Failed to fetch current user: \(error)")
            }
        }
    }
}
