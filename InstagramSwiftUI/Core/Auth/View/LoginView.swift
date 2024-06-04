//
//  LoginView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    @State private var isLoading = false
    
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
                    TextField("Enter your email", text: $loginViewModel.email)
                        .textInputAutocapitalization(.never)
                        .instaTextFieldViewModifier()
                    
                    SecureField("Enter your password", text: $loginViewModel.password)
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
                    isLoading = true
                    Task {
                        await loginViewModel.signIn()
                        isLoading = false
                    }
                } label: {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.white)
                            .instaButtonViewModifier()
                    } else {
                        Text("Sign in")
                            .instaButtonViewModifier()
                    }
                    
                }
                .disabled(isLoading ? true : !formIsValid)
                .opacity(formIsValid ? 1 : 0.7)
                
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

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        let isEmailValid = loginViewModel.email.isValidEmail
        let isPasswordValid = loginViewModel.password.isPasswordValid
        return isEmailValid && isPasswordValid
    }
}


#Preview {
    LoginView()
}
