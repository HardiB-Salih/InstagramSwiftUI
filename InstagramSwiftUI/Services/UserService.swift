//
//  UserService.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/5/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class UserService {
    static let shared = UserService()
    
    /// Fetches the current authenticated user from Firestore.
    ///
    /// This function performs an asynchronous fetch of the document corresponding to
    /// the currently authenticated user from the Firestore `users` collection. It returns
    /// an optional `User` object. If an error occurs during the fetch operation, the error
    /// is thrown.
    ///
    /// - Returns: An optional `User` object representing the current authenticated user,
    ///            or `nil` if the user is not authenticated or if the user document does
    ///            not exist.
    /// - Throws: An error if the fetch operation fails.
    /// - Note: The function requires the user to be authenticated. If the current user
    ///         is not authenticated, it returns `nil`.
    ///
    /// Example usage:
    /// ```swift
    /// do {
    ///     if let currentUser = try await fetchCurrentUser() {
    ///         print("Current user: \(currentUser)")
    ///     } else {
    ///         print("No authenticated user.")
    ///     }
    /// } catch {
    ///     print("Failed to fetch current user: \(error)")
    /// }
    /// ```
    func fetchCurrentUser() async throws -> User? {
        guard let currentUid = Auth.auth().currentUser?.uid else { return nil }
        
        do {
            let document = try await FirestoreCollections.users.document(currentUid).getDocument()
            let user = try document.data(as: User.self)
            return user
        } catch {
            throw error
        }
    }

    
    
    /// Fetches all users from Firestore, excluding the current user.
    ///
    /// This function performs an asynchronous fetch of user documents from the Firestore
    /// `users` collection, excluding the document of the currently authenticated user.
    /// It returns an array of `User` objects. If an error occurs during the fetch operation,
    /// the error is thrown.
    ///
    /// - Returns: An array of `User` objects, excluding the current user.
    /// - Throws: An error if the fetch operation fails.
    /// - Note: The function requires the user to be authenticated. If the current user
    ///         is not authenticated, it returns an empty array.
    ///
    /// Example usage:
    /// ```swift
    /// do {
    ///     let users = try await fetchAllUsers()
    ///     print(users)
    /// } catch {
    ///     print("Failed to fetch users: \(error)")
    /// }
    /// ```
    func fetchAllUsers() async throws -> [User] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
        
        do {
            let query = FirestoreCollections.users
                .whereField("id", isNotEqualTo: currentUid)
            let snapshot = try await query.getDocuments()
            let data = snapshot.documents.compactMap { try? $0.data(as: User.self) }
            
            return data
        } catch {
            throw error
        }
    }
    
    func fetchUserBy(userId id: String) async throws -> User {
        do {
            let document = try await FirestoreCollections.users.document(id).getDocument()
            let user = try document.data(as: User.self)
            return user
        } catch {
            throw error
        }
    }
    
    static func fetchUsers(by userIds: [String]) async throws -> [String: User] {
        guard !userIds.isEmpty else { return [:] }

        let db = Firestore.firestore()
        let userDocs = try await db.collection("users").whereField("uid", in: userIds).getDocuments()

        var users: [String: User] = [:]
        for document in userDocs.documents {
            guard let userId = document.data()["id"] as? String else { continue }
          let user = try document.data(as: User.self)
          users[userId] = user
        }

        return users
      }
}
