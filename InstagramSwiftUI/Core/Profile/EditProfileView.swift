//
//  EditProfileView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/5/24.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    var user: User
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel : EditProfileViewModel
    
    
    init(user: User) {
        self.user = user
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
    }
    
    var body: some View {
        ZStack {
            VStack {
                PhotosPicker(selection: $viewModel.selectedImage) {
                    VStack {
                        
                        //MARK: - Setup Post Image after piked
                        if let image = viewModel.profileImage {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                .padding(3)
                                .overlay { 
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .stroke(Color(.systemGray5), lineWidth: 2)
                                }
                                
                        } else {
                            RoundedImageView(viewModel.user.profileImageUrl,
                                             size: .xLarge,
                                             shape: .rounded(cornerRadius: 20))
                                .padding(3)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .stroke(Color(.systemGray4), lineWidth: 1.0)
                                }
                        }
                        
                        Text("Edit Profile Picture")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    
                }
                
                EditProfileRowView(title: "Name", placeholder: "Enter your fullname", text: $viewModel.fullname)
                EditProfileRowView(title: "Bio", placeholder: "Enter your bio", text: $viewModel.bio)

                Spacer()
            }
            .padding()

            
            
            if viewModel.isUploading {
                CustomProgressView(text: "Uploading")
                    .transition(.asymmetric(
                        insertion: .opacity.combined(with: .offset(y: 10)),
                        removal: .opacity.combined(with: .offset(y: -10))
                    ))
                    .zIndex(1)
            }
            
        }
        .animation(.easeInOut, value: viewModel.isUploading)
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            topBarLeading()
            topBarTrailing()
    }
    }
}

//MARK: -ToolbarContentBuilder
extension EditProfileView {
    @ToolbarContentBuilder
    private func topBarLeading() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button("Close", action: {dismiss()} )
        }
    }
    
    @ToolbarContentBuilder
    private func topBarTrailing() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Done") {
                Task {
                    try await viewModel.updateUserData()
                    dismiss()
                }
            }
            .disabled(viewModel.isUploading)
        }
    }
}

#Preview {
    EditProfileView(user: User.MOCK_USERS[0])
}

struct EditProfileRowView: View {
    let title: String
    let placeholder: String
    @Binding var text : String
    
    var body: some View {
        HStack {
            Text(title)
                .frame(width: 80, alignment: .leading)
            TextField(placeholder, text: $text)
        }
        .font(.subheadline)
        .frame(height: 36)
    }
}


