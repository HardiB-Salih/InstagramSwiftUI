//
//  AddEmailView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct AddEmailView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Add your email")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("You'll use this email to sign in to your account")
                .font(.footnote)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            // MARK: - TextField
            TextField("Enter your email", text: $viewModel.email)
                .textInputAutocapitalization(.never)
                .instaTextFieldViewModifier()
            
            // MARK: - Navigate To AddUserNameView
            NavigationLink {
                AddUserNameView()
            } label: {
                Text("Next")
                    .instaButtonViewModifier()
            }
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1 : 0.7)

            Spacer()
        }
        .navigationBarBackButtonHidden()
        .padding()
        .toolbar { topBarLeading() }
    }
}

//MARK: -ToolbarContentBuilder
extension AddEmailView {
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

extension AddEmailView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return viewModel.email.isValidEmail
    }
}




#Preview {
    AddEmailView()
}
