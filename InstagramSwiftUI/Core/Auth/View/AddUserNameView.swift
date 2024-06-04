//
//  AddUserNameView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct AddUserNameView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel

    
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
            TextField("Enter your username", text: $viewModel.username)
                .textInputAutocapitalization(.never)
                .instaTextFieldViewModifier()
            
            // MARK: - Navigate To AddPasswordView
            NavigationLink {
                AddPasswordView()
            } label: {
                Text("Next")
                    .instaButtonViewModifier()
            }
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1 : 0.7)
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

extension AddUserNameView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        let trimmedUsername = viewModel.username.trimmingCharacters(in: .whitespacesAndNewlines)
        return !trimmedUsername.isEmpty && trimmedUsername.count >= 3
    }
}


#Preview {
    AddUserNameView()
}
