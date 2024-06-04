//
//  LoginViewModel.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    private let authService = AuthService.shared
    
    
    func signIn() async {
        do {
            try await authService.login(withEmail: email, password: password)
            resetFields()
        } catch {
            print("🙀 Something went wrong Log in the user because: \(error.localizedDescription)")
        }
    }
    
    
    private func resetFields() {
        email = ""
        password = ""
    }
    
}
