//
//  NotificationCell.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/7/24.
//

import SwiftUI
import Kingfisher

struct NotificationCell: View {
    let notification: Notification
    var body: some View {
        HStack {
            NavigationLink(value: notification.user) {
                RoundedImageView(notification.user?.profileImageUrl, size:.xSmall, shape: .circle)
            }
            
            
            HStack {
                Text(notification.user?.username ?? "someone")
                    .font(.subheadline)
                    .fontWeight(.semibold) +
                
                Text(" \(notification.type.notificationMessage) ")
                    .font(.subheadline) +
                
                Text(notification.timestamp.timestampString())
                    .font(.footnote)
                    .foregroundStyle(.gray)
                
            }
            
            Spacer()
            
 
            if notification.type != .follow {
                NavigationLink(value: notification.post) {
                    KFImage(URL(string: notification.post?.imageUrl ?? ""))
                        .resizable()
                        .frame(width: 60, height: 60)
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                
                
            } else {
                Button(action: {
                    
                }, label: {
                    Text("Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                        .background(Color(.link))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                })
            }
        }
    }
}

#Preview {
    NotificationCell(notification: Notification.MOCK_Notifications.randomElement()!)
}
