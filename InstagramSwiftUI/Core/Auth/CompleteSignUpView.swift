//
//  CompleteSignUpView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct CompleteSignUpView: View {
    @State private var password = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 12) {
            VStack {
                Text("Welcom to instagram,")
                Text("hardib.salih")
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
                print("Sign up the User")
            } label: {
                Text("Complete Sign Up")
                    .instaButtonViewModifier()
                    .padding(.top)
            }
            
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
