//
//  ContentView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @StateObject private var registrationViewModel = RegistrationViewModel()

    var body: some View {
        Group {
            if viewModel.userSession != nil  {
                if let currentUser = viewModel.currentUser {
                    MainTabView(user: currentUser)
                }
            } else {
                LoginView()
                    .environmentObject(registrationViewModel)
            }
        }

    }
}

#Preview {
    ContentView()
}
