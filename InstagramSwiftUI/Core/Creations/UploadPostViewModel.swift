//
//  UploadPostViewModel.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI
import PhotosUI
import Firebase
import FirebaseFirestoreSwift

@MainActor
class UploadPostViewModel: ObservableObject {
    @Published var isUploading : Bool = false
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task {await loadImage(fromItem: selectedImage)}}
    }
    @Published var postImage: Image?
    private var uiImage: UIImage?
    
    // Asynchronously loads the image data from the PhotosPickerItem.
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }
    
    func uploadPost(caption: String) async throws {
        isUploading = true
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard let uiImage = uiImage else { return }
        do {
            let postRef = FirestoreCollections.posts.document()
            guard let imageUrl = try await ImageUploader.uploadImage(withUIImage: uiImage) else { return }
            let post = Post(id: postRef.documentID,
                            ownerUid: currentUid, caption: caption,
                            likes: 0, imageUrl: imageUrl, timestamp: Timestamp())
            
            guard let postEncoder = try? Firestore.Encoder().encode(post) else { return }
            try await postRef.setData(postEncoder)
            isUploading = false
        } catch {
            isUploading = false
            throw error
        }
       
        
    }
}
