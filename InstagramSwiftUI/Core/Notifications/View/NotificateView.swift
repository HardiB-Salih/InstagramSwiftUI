//
//  NotificateView.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/7/24.
//

import SwiftUI

struct NotificateView: View {
    @StateObject private var viewModel = NotificationViewModel(service: NotificationService())
    
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.notifications) { notification in
                        NotificationCell(notification: notification)
                    }
                }.padding()
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            .navigationDestination(for: Post.self, destination: { post in
                VStack {
                    FeedCell(post: post)
                    Spacer()
                }
            })
            
            
            .navigationTitle("otification")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NotificateView()
}
