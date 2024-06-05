//
//  EditProfileViewModel.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/5/24.
//

import SwiftUI
import PhotosUI
import Firebase

@MainActor
class EditProfileViewModel : ObservableObject {
    @Published var user: User
    @Published var fullname = ""
    @Published var bio = ""
    @Published var isUploading : Bool = false
    
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task {await loadImage(fromItem: selectedImage)}}
    }
    @Published var profileImage : Image?
    private var uiImage: UIImage?
    
    init(user: User) {
        self.user = user
        self.fullname = user.fullname ?? ""
        self.bio = user.bio ?? ""
    }
    
    // Asynchronously loads the image data from the PhotosPickerItem.
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws {
        isUploading = true
        var data = [String: Any]()
        
        // update profile image if change
        if let uiImage = uiImage {
            if let profileImageUrl = user.profileImageUrl {
                await ImageUploader.deleteFileFromFirebaseStorage(downloadUrl: profileImageUrl)
            }
            let profileImageUrl = try await ImageUploader.uploadImage(withUIImage: uiImage)
            data[.profileImageUrl] = profileImageUrl
            self.user.profileImageUrl = profileImageUrl
        }
        
        // update fullname if change
        if !fullname.isEmpty && user.fullname != fullname {
            data[.fullname] = fullname
            self.user.fullname = fullname
        }
        
        //update bio if change
        if !bio.isEmpty && user.bio != bio {
            data[.bio] = bio
            self.user.bio = bio
        }
        
        if !data.isEmpty {
            try await FirestoreCollections.users.document(user.id).updateData(data)
            try await AuthService.fetchCurrentUser()
        }
    }
     
}
