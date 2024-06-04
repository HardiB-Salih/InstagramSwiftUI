//
//  CompleteSignUpView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct CompleteSignUpView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    @State private var isLoading = false

    var body: some View {
        VStack(spacing: 12) {
            VStack {
                Text("Welcom to instagram,")
                Text(viewModel.username)
            }
            .font(.title2)
            .fontWeight(.bold)
            .padding(.top)
            
            Text("Click below to complete registration and start using Instagram")
                .font(.footnote)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            
            // MARK: - Sign up
            Button {
                isLoading = true
                Task {
                    await viewModel.createUser()
                    isLoading = false
                }
            } label: {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                        .instaButtonViewModifier()
                } else {
                    Text("Complete Sign Up")
                        .instaButtonViewModifier()
                        
                }
                
            }
            .padding(.top)
            .disabled(isLoading)
        }
        .padding()
        .navigationBarBackButtonHidden()
        .toolbar { topBarLeading() }
    }
}

//MARK: -ToolbarContentBuilder
extension CompleteSignUpView {
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
    CompleteSignUpView()
}
