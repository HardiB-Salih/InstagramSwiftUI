//
//  RegistrationViewModel.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import Foundation
class RegistrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var username = ""
    @Published var password = ""
    
    @MainActor
    func createUser() async {
        do {
            try await AuthService.shared.createUser(withEmail: email, 
                                             password: password,
                                             username: username)
            resetFields()
        } catch  {
            print("🙀:- Something went wront because - \(error.localizedDescription)")
        }
    }
    
    private func resetFields() {
        email = ""
        username = ""
        password = ""
    }
}
