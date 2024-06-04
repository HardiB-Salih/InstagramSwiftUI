//
//  AuthService.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import Foundation
import FirebaseAuth

class AuthService {
    @Published var userSession: FirebaseAuth.User?
    static let shared = AuthService()
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = authResult.user
        } catch {
            throw error
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, username: String) async throws {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = authResult.user
        } catch {
            throw error
        }
    }
    
    func loadUserData() async throws {}
    
    
    func signout() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
