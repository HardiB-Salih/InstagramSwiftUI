//
//  AddUserNameView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct AddUserNameView: View {
    @State private var username = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Create Username")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("You'll use this email to sign in to your account")
                .font(.footnote)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            // MARK: - TextField
            TextField("Enter your username", text: $username)
                .textInputAutocapitalization(.never)
                .instaTextFieldViewModifier()
            
            // MARK: - Navigate To AddPasswordView
            NavigationLink {
                AddPasswordView()
            } label: {
                Text("Next")
                    .instaButtonViewModifier()
            }
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden()
        .toolbar { topBarLeading() }
    }
}

//MARK: -ToolbarContentBuilder
extension AddUserNameView {
    @ToolbarContentBuilder
    private func topBarLeading() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: { dismiss() }, label: {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .foregroundStyle(Color(.label))
            })
        }
    }
}

#Preview {
    AddUserNameView()
}
