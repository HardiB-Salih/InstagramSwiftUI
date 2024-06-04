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
            VStack {
                HStack (alignment: .top, spacing: 12){
                    
                    //MARK: - Setup Post Image after piked
                    Group {
                        if let image = uploadPostVM.postImage {
                            image
                                .resizable()
                        } else {
                            Image("scarlet-witch")
                                .resizable()
                        }
                    }
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .onTapGesture {
                        pickerPresented.toggle()
                    }
                    
                    
                    TextField("Enter your caption", text: $postCaption, axis: .vertical)
                }
                Spacer()
            }
            .padding()
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
            Button("Upload") { print("Upload") }
                .fontWeight(.heavy)
            
        }
    }
    
    @ToolbarContentBuilder
    private func topBarPrincipal() -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text("New Post")
                .fontWeight(.heavy)
        }
    }
}

#Preview {
    UploadPostView()
}
