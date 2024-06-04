//
//  LoginView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // MARK: - Logo Image
                Image("Instagram_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 100)
                
                
                // MARK: - TextField
                VStack {
                    TextField("Enter your email", text: $email)
                        .textInputAutocapitalization(.never)
                        .instaTextFieldViewModifier()
                    
                    SecureField("Enter your password", text: $password)
                        .instaTextFieldViewModifier()
                }
                
                
                // MARK: - Forgot Password
                NavigationLink {
                    Text("Forgot Password")
                } label: {
                    Text("Forgot Password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.vertical)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                
                // MARK: - Sign in
                Button {
                    print("Sign in")
                } label: {
                    Text("Sign in")
                        .instaButtonViewModifier()
                }
                
                // MARK: - Divider With Text
                HStack {
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40 , height: 1)
                    
                    Text("OR")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40 , height: 1)
                }
                .foregroundStyle(Color(.systemGray4))
                .padding(.top, 8)
                
                
                // MARK: - Sign in with Facebook
                Button(action: {
                    print("Sign in with Facebook")
                }, label: {
                    HStack (spacing: 8){
                        Image("facebook")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.white)
                            .frame(width: 28, height: 28)
                        
                        Text("Continue with Facebook")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(.systemBlue))
                    }
                })
                
                Spacer()
                Divider()
                
                // MARK: - Navigate To AddEmailView
                NavigationLink {
                    AddEmailView()
                } label: {
                    HStack {
                        Text("Don't have an account? ") +
                        Text("Sign up")
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                    .foregroundStyle(Color(.label))
                    .padding(.top, 8)
                }
            }
            .padding(.horizontal)
        }
    }
}


#Preview {
    LoginView()
}
