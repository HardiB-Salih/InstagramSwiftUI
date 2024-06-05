//
//  AuthService.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import Foundation
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

var AuthService = _AuthService()
class _AuthService: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?

//    static let shared = AuthService()
    
    init() {
        Task {
            try await fetchCurrentUser()
        }
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            _ = try await Auth.auth().signIn(withEmail: email, password: password)
            try await fetchCurrentUser()
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
            guard let userEncoder = try? Firestore.Encoder().encode(user) else {
                throw AuthServiceError.encodingError
            }
            try await FirestoreCollections.users.document(user.id).setData(userEncoder)
        } catch {
            throw AuthServiceError.firestoreError(error.localizedDescription)
        }
    }
    
        func fetchCurrentUser() async throws {
            guard let currentUid = Auth.auth().currentUser?.uid else { return }
    
            do {
                let document = try await FirestoreCollections.users.document(currentUid).getDocument()
                let user = try document.data(as: User.self)
                self.userSession = Auth.auth().currentUser
                self.currentUser = user
            } catch {
                throw error
            }
        }
    func signout() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
        } catch {
            print(AuthServiceError.signOutError(error.localizedDescription))
        }
    }
}
