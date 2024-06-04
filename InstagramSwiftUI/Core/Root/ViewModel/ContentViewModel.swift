//
//  ContentViewModel.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import Foundation
import Firebase
import Combine

class ContentViewModel: ObservableObject {
    private let authService = AuthService.shared
    
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setUpSubscribers()
    }
    
    
    func setUpSubscribers() {
        authService.$userSession.sink {[ weak self ] userSession in
            guard let self else { return }
            self.userSession = userSession
        }.store(in: &cancellables)
    }
}
