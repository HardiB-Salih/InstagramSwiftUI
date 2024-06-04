//
//  AddPasswordView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct AddPasswordView: View {
    @State private var password = ""
    @Environment(\.dismiss) private var dismiss
    
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
            SecureField("Enter your password", text: $password)
                .instaTextFieldViewModifier()
            
            // MARK: - Navigate To CompleteSignUpView
            NavigationLink {
                CompleteSignUpView()
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

#Preview {
    AddPasswordView()
}
