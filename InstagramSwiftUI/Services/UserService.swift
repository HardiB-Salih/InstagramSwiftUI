//
//  UserService.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/5/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

let UserService = _UserService()
class _UserService {
    @Published var currentUser: User?
    
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
    @MainActor
    func fetchCurrentUser() async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        do {
            self.currentUser = try await FirestoreCollections.users.document(currentUid).getDocument(as: User.self)
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


//MARK: Following
extension _UserService {
    //MARK: Follow
    /**
     Adds a user to the current user's following list and adds the current user to the specified user's followers list.
     
     - Parameter uid: The user ID of the user to follow.
     
     - Throws: An error if the operation fails.
     
     # Usage Example #
     ```swift
     do {
     try await follow(uid: "someUserId")
     print("Followed successfully")
     } catch {
     print("Failed to follow: (error)")
     }
     ```
     
     # Implementation Details #
     - The function first ensures the current user is authenticated.
     - It then gets references to the current user's following document and the specified user's followers document.
     - Uses Firestore's `runTransaction` method to atomically add the follow relationship, ensuring consistency.
     - If the transaction fails, an error is thrown.
     */
    func follow(uid: String) async throws {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        let userFollowingRef = FirestoreCollections.following.document(currentUserId).collection(.userFollowing).document(uid)
        let userFollowersRef = FirestoreCollections.followers.document(uid).collection(.userFollowers).document(currentUserId)
        
        do {
            _ = try await Firestore.firestore().runTransaction { transaction, _ in
                transaction.setData([:], forDocument: userFollowingRef)
                transaction.setData([:], forDocument: userFollowersRef)
                return nil
            }
        } catch {
            throw error
        }
    }
    
    //MARK: unFollow
    /**
     Removes a user from the current user's following list and removes the current user from the specified user's followers list.
     
     - Parameter uid: The user ID of the user to unfollow.
     
     - Throws: An error if the operation fails.
     
     # Usage Example #
     ```swift
     do {
     try await unfollow(uid: "someUserId")
     print("Unfollowed successfully")
     } catch {
     print("Failed to unfollow: (error)")
     }
     ```
     
     # Implementation Details #
     - The function first ensures the current user is authenticated.
     - It then gets references to the current user's following document and the specified user's followers document.
     - Uses Firestore's `runTransaction` method to atomically remove the follow relationship, ensuring consistency.
     - If the transaction fails, an error is thrown.
     */
    
    func unfollow(uid: String) async throws {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        
        let userFollowingRef = FirestoreCollections.following.document(currentUserId).collection(.userFollowing).document(uid)
        let userFollowersRef = FirestoreCollections.followers.document(uid).collection(.userFollowers).document(currentUserId)
        
        do {
            _ = try await Firestore.firestore().runTransaction { transaction, _ in
                transaction.deleteDocument(userFollowingRef)
                transaction.deleteDocument(userFollowersRef)
                return nil
            }
        } catch {
            throw error
        }
    }
    
    
    //MARK: checkIfUserFollowed
    /**
     Checks if the current user is following the specified user.
     - Parameter uid: The user ID of the user to check.

     - Returns: A `Bool` indicating whether the current user is following the specified user.

     - Throws: An error if the operation fails.

     # Usage Example #
     ```swift
     do {
     let isFollowing = try await checkIfUserFollowed(uid: "someUserId")
     print("Is following: (isFollowing)")
     } catch {
     print("Failed to check if user is followed: (error)")
     }
     ```
     
     # Implementation Details #
     - The function first ensures the current user is authenticated.
     - It then gets a reference to the document representing the follow relationship in the current user's following collection.
     - Uses Firestore's `getDocument` method to fetch the document snapshot and checks its existence to determine if the follow relationship exists.
     - If the user is not authenticated, the function returns `false`.
     - If the operation fails, an error is thrown.
     */

//    func checkIfUserFollowed(uid: String) async throws -> Bool {
//        guard let currentUserId = Auth.auth().currentUser?.uid else { return false }
//        let userFollowingRef = FirestoreCollections.following.document(currentUserId).collection(.userFollowing).document(uid)
//        let documentSnapshot = try await userFollowingRef.getDocument()
//        return documentSnapshot.exists
//    }
    
    func checkIfUserFollowed(uid: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let currentUserId = Auth.auth().currentUser?.uid else {
            completion(.success(false))
            return
        }
        
        let userFollowingRef = FirestoreCollections.following.document(currentUserId).collection(.userFollowing).document(uid)
        
        userFollowingRef.getDocument { documentSnapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(documentSnapshot?.exists ?? false))
            }
        }
    }



}

extension String {
    static let userFollowing = "user-following"
    static let userFollowers = "user-followers"
    
}




//    func follow(uid: String) async throws {
//        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
//
//        let userFollowingRef = FirestoreCollections.following.document(currentUserId).collection(.userFollowing).document(uid)
//        let userFollowersRef = FirestoreCollections.following.document(uid).collection(.userFollowers).document(currentUserId)
//
//        do {
//
//            async let userFollowing : Void = userFollowingRef.setData([:])
//            async let userFollowers : Void = userFollowersRef.setData([:])
//
//            // Await all tasks to ensure they complete
//            _ = try await (userFollowing, userFollowers)
//        } catch {
//            throw error
//        }
//    }

//    func unfollow(uid: String) async throws {
//        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
//
//        let userFollowingRef = FirestoreCollections.following.document(currentUserId).collection(.userFollowing).document(uid)
//        let userFollowersRef = FirestoreCollections.following.document(uid).collection(.userFollowers).document(currentUserId)
//
//
//        do {
//            async let userFollowing : Void = userFollowingRef.delete()
//            async let userFollowers : Void = userFollowersRef.delete()
//
//            // Await all tasks to ensure they complete
//            _ = try await (userFollowing, userFollowers)
//        } catch {
//            throw error
//        }
//    }
