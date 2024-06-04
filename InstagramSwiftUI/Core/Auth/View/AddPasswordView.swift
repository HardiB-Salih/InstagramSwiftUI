//
//  AddPasswordView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct AddPasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel

    var body: some View {
        VStack(spacing: 12) {
            Text("Create a password")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("Your password must be at least 6 charecters in length")
                .font(.footnote)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            // MARK: - TextField
            SecureField("Enter your password", text: $viewModel.password)
                .instaTextFieldViewModifier()
            
            // MARK: - Navigate To CompleteSignUpView
            NavigationLink {
                CompleteSignUpView()
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
extension AddPasswordView {
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

extension AddPasswordView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return viewModel.password.isPasswordValid
    }
}

#Preview {
    AddPasswordView()
}
