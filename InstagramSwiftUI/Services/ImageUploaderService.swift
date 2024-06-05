//
//  ImageUploaderService.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/5/24.
//

import UIKit
import FirebaseCore
import Firebase
import FirebaseStorage

enum ImageFormat {
    case png
    case jpeg(compressionQuality: CGFloat)
}

let ImageUploader = ImageUploaderService()
class ImageUploaderService {
    private let PROJECT_ID = "instagramswiftui-5fffb"
    
    /// Uploads an image to Firebase Storage and returns the download URL.
    ///
    /// - Parameters:
    ///   - image: The `UIImage` to be uploaded.
    ///   - format: The format to upload the image as, specified using the `ImageFormat` enum.
    ///   - folderName: The folder in Firebase Storage where the image will be stored. Defaults to "profile".
    ///   - fileName: The name of the file to be uploaded. Defaults to a unique UUID string.
    ///
    /// - Returns: A `String?` containing the download URL of the uploaded image if successful, or `nil` if the image data could not be created.
    ///
    /// - Throws: An error if the upload process fails.
    ///
    /// - Usage Example:
    /// ```swift
    /// do {
    ///     if let downloadUrl = try await uploadImage(
    ///         withUIImage: myUIImage,
    ///         format: .png,
    ///         folderName: "profile_pictures"
    ///     ) {
    ///         print("Image uploaded successfully! Download URL: \(downloadUrl)")
    ///     } else {
    ///         print("Failed to compress image")
    ///     }
    /// } catch {
    ///     print("Failed to upload image: \(error.localizedDescription)")
    /// }
    /// ```
    func uploadImage(
        withUIImage image: UIImage,
        format: ImageFormat = .jpeg(compressionQuality: 0.25),
        folderName: String = "profile_pictures",
        fileName: String = UUID().uuidString
    ) async throws -> String? {
        let imageData: Data?
        let fileExtension: String
        
        switch format {
        case .png:
            imageData = image.pngData()
            fileExtension = "png"
        case .jpeg(let compressionQuality):
            imageData = image.jpegData(compressionQuality: compressionQuality)
            fileExtension = "jpeg"
        }
        
        guard let data = imageData else { return nil }
        
        let storage = Storage.storage().reference()
        let ref = storage.child("/\(folderName)/\(fileName).\(fileExtension)")
        
        do {
            let _ = try await ref.putDataAsync(data)
            let url = try await ref.downloadURL()
            return url.absoluteString
        } catch {
            print("🙀 Image did not upload: \(error.localizedDescription)")
            throw error
        }
    }
    
    

    /// Deletes a file from Firebase Storage using its download URL.
    ///
    /// - Parameter downloadUrl: The download URL of the file to be deleted.
    ///
    /// - Throws: An error if the deletion process fails.
    ///
    /// - Usage Example:
    /// ```swift
    /// do {
    ///     try await deleteFileFromFirebaseStorage(downloadUrl: "https://firebasestorage.googleapis.com:443/v0/b/tinderuikit.appspot.com/o/somefile.jpg?alt=media&token=some-token")
    ///     print("File deleted successfully!")
    /// } catch {
    ///     print("Failed to delete file: \(error.localizedDescription)")
    /// }
    /// ```
    func deleteFileFromFirebaseStorage(downloadUrl: String) async {
        // Extract the file path from the download URL
        guard let filePath = extractPath(fromUrl: downloadUrl) else { return }
        
        // Create a reference to the file in Firebase Storage
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child(filePath)
        
        // Try to delete the file
        do {
            try await fileRef.delete()
            print("File deleted successfully!")
        } catch {
            print("🙀 Could not delete the file at path:\(filePath) because \(error.localizedDescription)")
        }
    }
    
    /// Extracts the path from a Firebase Storage download URL.
    ///
    /// - Parameter url: The download URL from which to extract the path.
    ///
    /// - Returns: A `String?` containing the extracted path if successful, or `nil` if the URL does not match the expected pattern.
    ///
    /// - Usage Example:
    /// ```swift
    /// if let path = extractPath(fromUrl: "https://firebasestorage.googleapis.com:443/v0/b/tinderuikit.appspot.com/o/somefile.jpg?alt=media&token=some-token") {
    ///     print("Extracted path: \(path)")
    /// } else {
    ///     print("Failed to extract path")
    /// }
    /// ```
    func extractPath(fromUrl url: String) -> String? {
        let pattern = "https://firebasestorage.googleapis.com:443/v0/b/\(PROJECT_ID).appspot.com/o/"

        guard let range = url.range(of: pattern) else { return nil }
        let pathPart = url[range.upperBound...]
        
        if let queryIndex = pathPart.range(of: "?")?.lowerBound {
            let encodedPath = String(pathPart[..<queryIndex])
            return encodedPath.removingPercentEncoding
        }
        return nil
    }
}
