//
//  AuthService.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

enum AuthServiceError: Error {
    case encodingError
    case signOutError(String)
    case firebaseAuthError(String)
    case firestoreError(String)
    case unknownError(String)
    
    var localizedDescription: String {
        switch self {
        case .encodingError:
            return "Failed to encode user data."
        case .signOutError(let message):
            return "Failed to sign out: \(message)"
        case .firebaseAuthError(let message):
            return "Firebase Auth error: \(message)"
        case .firestoreError(let message):
            return "Firestore error: \(message)"
        case .unknownError(let message):
            return "An unknown error occurred: \(message)"
        }
    }
}

class AuthService: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    static let shared = AuthService()
    
    init() {
        Task { try await loadUserData() }
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            try await loadUserData()
        } catch {
            throw AuthServiceError.firebaseAuthError(error.localizedDescription)
        }
    }
    
    @MainActor
    func createUser(withEmail email: String, password: String, username: String) async throws {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = authResult.user
            try await uploadUserData(id: authResult.user.uid, email: email, username: username)
        } catch {
            throw AuthServiceError.firebaseAuthError(error.localizedDescription)
        }
    }
    
    
    private func uploadUserData(id: String, email: String, username: String) async throws {
        do {
            let user = User(id: id, username: username, email: email)
            UserService.currentUser = user
            guard let userEncoder = try? Firestore.Encoder().encode(user) else {
                throw AuthServiceError.encodingError
            }
            try await FirestoreCollections.users.document(user.id).setData(userEncoder)
        } catch {
            throw AuthServiceError.firestoreError(error.localizedDescription)
        }
    }
    
    @MainActor
    func loadUserData() async throws {
        self.userSession = Auth.auth().currentUser
        try await UserService.fetchCurrentUser()
    }
    
    func signout() {
        try? Auth.auth().signOut()
        self.userSession = nil
        UserService.currentUser = nil
    }
}
