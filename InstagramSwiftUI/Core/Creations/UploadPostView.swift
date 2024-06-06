//
//  UploadPostView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {
    @State private var postCaption = ""
    @State private var pickerPresented = false
    @StateObject private var uploadPostVM = UploadPostViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack (alignment: .top, spacing: 12){
                        
                        //MARK: - Setup Post Image after piked
                        Group {
                            if let image = uploadPostVM.postImage {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                    .padding(3)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                                            .stroke(Color(.systemGray4), lineWidth: 1.0)
                                    }
                            } else {
                                RoundedImageView(size: .xLarge, 
                                                 shape: .rounded(cornerRadius: 16), fallbackImage: "photo.fill")
                                    .padding(3)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                                            .stroke(Color(.systemGray4), lineWidth: 1.0)
                                    }
                            }
                        }
                        .onTapGesture {
                            pickerPresented.toggle()
                        }
                        TextField("Enter your caption", text: $postCaption, axis: .vertical)
                    }
                    Spacer()
                }
                .padding()
                
                
                if uploadPostVM.isUploading {
                    CustomProgressView(text: "Uploading")
                        .transition(.asymmetric(
                            insertion: .opacity.combined(with: .offset(y: 10)),
                            removal: .opacity.combined(with: .offset(y: -10))
                        ))
                        .zIndex(1)
                }
                
            }
            .animation(.easeInOut, value: uploadPostVM.isUploading)
            .navigationBarTitleDisplayMode(.inline)
            .photosPicker(isPresented: $pickerPresented, selection: $uploadPostVM.selectedImage)
            .toolbar{
                topBarLeading()
                topBarPrincipal()
                topBarTrailing()
            }
        }
    }
    
}


//MARK: -ToolbarContentBuilder
extension UploadPostView {
    @ToolbarContentBuilder
    private func topBarLeading() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button("Cancel") { dismiss() }
        }
    }
    
    @ToolbarContentBuilder
    private func topBarTrailing() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Upload") {
                Task {
                    try await uploadPostVM.uploadPost(caption: postCaption)
                    dismiss()
                }
            }
            .disabled(uploadPostVM.isUploading)
            .fontWeight(.medium)
        }
    }
    
    @ToolbarContentBuilder
    private func topBarPrincipal() -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text("New Post")
                .fontWeight(.medium)
        }
    }
}

#Preview {
    UploadPostView()
}
