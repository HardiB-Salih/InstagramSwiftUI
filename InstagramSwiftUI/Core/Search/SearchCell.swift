//
//  SearchCell.swift
//  InstagramSwiftUI
//
//  Created by HardiB.Salih on 6/4/24.
//

import SwiftUI

struct SearchCell: View {
    let user: User
    
    var body: some View {
        HStack {
            Image(user.profileImageUrl ?? "iron-man")
                .resizable()
                .clipShape(Circle())
                .padding(3)
                .overlay { Circle().stroke(Color(.systemGray5), lineWidth: 1) }
                .frame(width: 40, height: 40)
            
            VStack (alignment: .leading){
                Text(user.username)
                    .fontWeight(.semibold)
                
                if let fullname = user.fullname {
                    Text(fullname)
                }
                
            }
            .font(.footnote)
            Spacer()
        }
        .foregroundColor(Color(.label))
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

#Preview {
    SearchCell(user: User.MOCK_USERS.randomElement()!)
}
